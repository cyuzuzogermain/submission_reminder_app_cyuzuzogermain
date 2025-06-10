#!/bin/bash

read -p "Enter your name " username

mkdir submission_reminder_$username

cd submission_reminder_$username

mkdir app modules assets config

touch app/reminder.sh
touch modules/functions.sh
touch assets/submissions.txt
touch config/config.env
touch startup.sh
