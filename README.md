Assignment submission reminder


## 📁 Project Structure

submission_reminder_{yourName}/
├── app/

│ └── reminder.sh

├── modules/

│ └── functions.sh

├── assets/

│ └── submissions.txt

├── config/

│ └── config.env

└── startup.sh

Step 2: Run the Environment Setup Script
This will create your working app folder with your name and generate all necessary files.

bash
Copy
Edit
bash create_environment.sh
You will be prompted to enter your name. For example, entering Jane will create:

Copy
Edit
submission_reminder_Jane/
Step 3: Run the Reminder App
Navigate into the directory that was created and run:

bash
Copy
Edit
cd submission_reminder_Jane
./startup.sh
This will:

Load your configuration (assignment name and deadline).

Show







You said:
I want you to generate a readme file for this project


ChatGPT said:
Here’s a complete and polished README.md file for your submission_reminder_app project. It includes sections on project overview, setup, usage, structure, and Git workflow based on the assignment instructions you provided.

markdown
Copy
Edit
# 📬 submission_reminder_app

A simple shell-based application that helps identify students who have not submitted their assignments. It’s designed as a learning exercise for managing directories, environment variables, shell scripting, and Git workflows.

---

## 📁 Project Overview

This project contains two primary shell scripts:

- `create_environment.sh` – Creates the folder structure and populates files required for the submission reminder app.
- `copilot_shell_script.sh` – Allows dynamic switching of assignments and rechecking submission status.

Once the environment is set up, the app reads from a list of student submissions and prints reminders for students who have not submitted a specified assignment.

---

## 🛠️ Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/<your-github-username>/submission_reminder_app_<your-github-username>.git
cd submission_reminder_app_<your-github-username>
2. Run the Environment Setup Script
This creates the project structure and sets up sample data:

bash
Copy
Edit
bash create_environment.sh
You will be prompted to enter your name. This will generate a directory named:

php-template
Copy
Edit
submission_reminder_<yourName>
Inside, you'll find subdirectories and files like:

app/reminder.sh

modules/functions.sh

assets/submissions.txt

config/config.env

startup.sh

▶️ How to Use
Run the Reminder App
From inside the created folder:

bash
Copy
Edit
cd submission_reminder_<yourName>
./startup.sh
The script will:

Load assignment details from config/config.env

Check for students with not submitted status

Print reminders for those students

Change the Assignment Being Checked
You can change the assignment being checked using:

bash
Copy
Edit
./copilot_shell_script.sh
You'll be prompted to enter a new assignment name.

The script updates config/config.env and re-runs the reminder check.

🧾 Sample Data Format
The assets/submissions.txt file should follow this structure:

python-repl
Copy
Edit
student,assignment,submission status
John Doe,Shell Navigation,not submitted
Jane Smith,Git,submitted
...
You can add more records to test the reminder functionality.

🌿 Git Workflow
You are expected to use two Git branches:

feature/setup – For development and testing.

main – For the final working application.

Only the following files should be in your main branch:

Copy
Edit
create_environment.sh
copilot_shell_script.sh
README.md
📌 Notes
Make sure all .sh files are executable. Use:
chmod +x *.sh

The script uses sed for in-place editing of configuration files.

Works on most Unix/Linux systems with bash.
