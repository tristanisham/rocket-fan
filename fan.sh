#!/usr/bin/env bash


# Check for the existence of the fan executable in different directories
if [[ -x "../fan/build/debug/fan" ]]; then
    FAN_EXEC="../fan/build/debug/fan"
elif [[ -x "../fan/build/release/fan" ]]; then
    FAN_EXEC="../fan/build/release/fan"
else
    FAN_EXEC="../fan/build/fan"
fi

# Execute the fan command with the given arguments
FAN_LIB=../fan/lang $FAN_EXEC "$@"
