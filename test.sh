
if [[ -z "${python_cmd}" ]]
then
    python_cmd="python3"
fi

if [[ -z "${LAUNCH_SCRIPT}" ]]
then
    LAUNCH_SCRIPT="launch.py"
fi

printf "${python_cmd} ${LAUNCH_SCRIPT} $@"
        