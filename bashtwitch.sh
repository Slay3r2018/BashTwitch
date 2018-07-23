#!
clear 
echo_c()
{
  w=$(stty size | cut -d" " -f2)       # width of the terminal
  l=${#1}                              # length of the string
  printf "%"$((l+(w-l)/2))"s\n" "$1"   # print string padded to proper width (%Ws)
}

echo_c "______           _   _____        _ _       _     "     
echo_c "| ___ \         | | |_   _|      (_) |     | |    "    
echo_c '| |_/ / __ _ ___| |__ | |_      ___| |_ ___| |__  '  
echo_c '| ___ \/ _` / __|  _ \| \ \ /\ / / | __/ __| _  \ ' 
echo_c '| |_/ / (_| \__ \ | | | |\ V  V /| | || (__| | | |'
echo_c "\____/ \__,_|___/_| |_\_/ \_/\_/ |_|\__\___|_| |_|"
echo_c "and chill."                                                  

echo " "
echo " "

 
 
echo "Please enter your choice: "
options=("Watch live streams" "Watch VODS" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Watch live streams")
            echo "Chose streamer: "
            read varname
            streamlink 'http://www.twitch.tv/'$varname best --quiet -p "mpv --fullscreen"
            echo "Loading stream. Please wait."
            ;;
        "Watch VODS")
            echo "Chose streamer: "
            read varname
            echo "Chose number of vods for your playlist: "
            read vodnum
            echo "Loading vods. Please wait."
            #get user_id from twitch
            id=$(curl -s -H 'Client-ID: zlewe41owr1266gt1hgauozqqrbeyy' \ -X GET https://api.twitch.tv/helix/users?login=$varname | jq -r '[.data[].id]|.[]')
            #pass id to get urls
            link=$(curl -s -H 'Client-ID: zlewe41owr1266gt1hgauozqqrbeyy' \ -X GET 'https://api.twitch.tv/helix/videos?user_id='$id'&period=day&sort=time&first='$vodnum | jq -r '[.data[].url]|.[]')
            #pass url to mpv
            mpv $link --fullscreen --really-quiet
            ;;
        "Quit")
            break
            ;;
    esac
done
