execution_info () {
  echo -e "\n\ncommand: $0 \n"
  echo -e "arguments: $@ \n\n"
}

when_debug () {
if [ ${MARKETODEBUG} ] ; then
  $1
fi
}

no_args_display () {
if [ $1 -eq 0 ]
  then
    echo -e "\n\nUsage: "${correctusage}"\n"
    exit 1
fi
}

check_response () {
if [ $# -eq 0 ]
  then
    if [ $(cat "${MARKETOUPDATERESPONSE}" | jq '.["success"]' | tail -n 1 ) = "true" ]
      then
        echo -e "\e[32mSUCCESS!\e[0m"
      else
        echo -e "\n\n\e[31mFailure!\e[0m\n\n"
        echo "Errors: $(cat "${MARKETOUPDATERESPONSE}" | jq -r '.["errors"]')" | tail -n 6
    fi
fi
if [ $# -eq 1 ]
  then
        if [ $(cat "$1" | jq '.["success"]' | tail -n 1 ) = "true" ]
      then
        echo -e "\e[32mSUCCESS!\e[0m"
      else
        echo -e "\n\n\e[31mFailure!\e[0m\n\n"
        echo "Errors: $(cat "$1" | jq -r '.["errors"]')" | tail -n 6
    fi
fi
}

