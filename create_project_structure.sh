#!/bin/bash

# Function to print centered text
#print_centered() {
#   local text="$1"
#   local width=$(tput cols)
#  local padding="$((($width - ${#text}) / 2))"
#   printf "%*s%s%*s\n" $padding "" "$text" $padding ""
#}

# Function to install tree command
install_tree() {
    # Check if tree is already installed
    if ! command -v tree &> /dev/null; then
        echo "( Installing tree command... )"
        # Install tree based on the package manager
        if [ -x "$(command -v apt-get)" ]; then
            sudo apt-get update
            sudo apt-get install -y tree
        elif [ -x "$(command -v yum)" ]; then
            sudo yum install -y tree
        elif [ -x "$(command -v brew)" ]; then
            brew install tree
        else
            echo "( Unsupported package manager. Please install tree manually and run the script again. )"
            exit 1
        fi
        echo "                   ( tree command installed. )"
    else
        echo "                   ( tree command is already installed. )"
    fi
}

# Function to create virtual environment
create_virtualenv() {
    read -p "🐍 Do you want to create a virtual environment? (y/n): " create_venv
    create_venv=$(echo "$create_venv" | tr '[:upper:]' '[:lower:]')  # Convert to lowercase
    if [ "$create_venv" == "y" ]; then
        read -p "Enter the Python version (e.g., 3.8, press Enter for default): " python_version
        python_version="${python_version:-3.8}"  # Set default Python version to 3.8
        python3 -m venv .env --without-pip
        source .env/bin/activate
        curl https://bootstrap.pypa.io/get-pip.py | python
        echo "( Virtual environment created and activated. )"
    else
        echo "( Skipping virtual environment creation. )"
    fi
}

# Function to create .gitignore file
create_gitignore() {
    read -p "🚫 Do you want to ignore the dataset? (y/n): " ignore_dataset
    echo
    ignore_dataset=$(echo "$ignore_dataset" | tr '[:upper:]' '[:lower:]')  # Convert to lowercase
    if [ "$ignore_dataset" == "y" ]; then
        echo "data/raw" >> .gitignore
        echo "data/processed" >> .gitignore
        echo "data/interim" >> .gitignore
        echo "data/external" >> .gitignore
    fi
    echo
    read -p "🚫 Do you want to ignore inference data? (y/n): " ignore_inference
    ignore_inference=$(echo "$ignore_inference" | tr '[:upper:]' '[:lower:]')  # Convert to lowercase
    if [ "$ignore_inference" == "y" ]; then
        echo "logs" >> .gitignore
    fi
    echo
    read -p "🚫 Do you want to ignore trained weights? (y/n): " ignore_weights
    ignore_weights=$(echo "$ignore_weights" | tr '[:upper:]' '[:lower:]')  # Convert to lowercase
    if [ "$ignore_weights" == "y" ]; then
        echo "models" >> .gitignore
    fi
    echo
    echo
    echo  "( .gitignore file created. )"
}

# Function to create professional documentation
create_documentation() {
    doc_filename="${project_name}_dir_structure_info.md"
    touch $doc_filename
    echo "# Project Structure Documentation" >> $doc_filename
    echo "This documentation provides a clear overview of the generated project structure." >> $doc_filename
    echo "## Project Structure" >> $doc_filename
    tree -L 3 --dirsfirst >> $doc_filename
    echo "## File and Directory Descriptions" >> $doc_filename
    echo "### data/" >> $doc_filename
    echo "This directory is used for storing raw, processed, interim, and external data." >> $doc_filename
    echo "### notebooks/" >> $doc_filename
    echo "This directory contains Jupyter notebooks for exploration and experimentation." >> $doc_filename
    echo "### src/" >> $doc_filename
    echo "This directory contains the source code for the project, organized into subdirectories based on functionality." >> $doc_filename
    echo "#### src/data_preprocessing/" >> $doc_filename
    echo "This directory contains scripts for cleaning and preprocessing data." >> $doc_filename
    echo "#### src/feature_engineering/" >> $doc_filename
    echo "This directory contains scripts for feature engineering." >> $doc_filename
    echo "#### src/model/" >> $doc_filename
    echo "This directory contains scripts for defining and training models." >> $doc_filename
    echo "#### src/evaluation/" >> $doc_filename
    echo "This directory contains scripts for model evaluation." >> $doc_filename
    echo "#### src/utils/" >> $doc_filename
    echo "This directory contains utility scripts and helper functions." >> $doc_filename
    echo "### models/" >> $doc_filename
    echo "This directory is used for storing saved model files." >> $doc_filename
    echo "### logs/" >> $doc_filename
    echo "This directory is used for storing log files and model training logs." >> $doc_filename
    echo "### reports/" >> $doc_filename
    echo "This directory is used for storing project reports and documentation." >> $doc_filename
    echo "### requirements.txt" >> $doc_filename
    echo "This file lists the Python dependencies for the project." >> $doc_filename
    echo "### config.yml" >> $doc_filename
    echo "This file contains configuration settings for the project." >> $doc_filename
    echo "### main.py" >> $doc_filename
    echo "This is the main script for running the project." >> $doc_filename
    echo "## Python Files" >> $doc_filename
    echo "### main.py" >> $doc_filename
    echo "Your main script for running the project." >> $doc_filename
    echo "### src/data_preprocessing/__init__.py" >> $doc_filename
    echo "Your Python module for data preprocessing." >> $doc_filename
    echo "### src/feature_engineering/__init__.py" >> $doc_filename
    echo "Your Python module for feature engineering." >> $doc_filename
    echo "### src/model/__init__.py" >> $doc_filename
    echo "Your Python module for defining and training models." >> $doc_filename
    echo "### src/evaluation/__init__.py" >> $doc_filename
    echo "Your Python module for model evaluation." >> $doc_filename
    echo "### src/utils/__init__.py" >> $doc_filename
    echo "Your Python module for utility functions." >> $doc_filename
    echo "### src/model_train.py" >> $doc_filename
    echo "Your script for training the machine learning model." >> $doc_filename
    echo "### src/model_test.py" >> $doc_filename
    echo "Your script for testing the machine learning model." >> $doc_filename
    echo "### src/model_detect.py" >> $doc_filename
    echo "Your script for using the trained model for detection or prediction." >> $doc_filename
    echo "### make_dataset.py" >> $doc_filename
    echo "Your script for creating or downloading the dataset." >> $doc_filename
    echo "## Usage" >> $doc_filename
    echo "To run the project, execute the following command:" >> $doc_filename
    echo "\`\`\`bash" >> $doc_filename
    echo "./main.py" >> $doc_filename
    echo "\`\`\`" >> $doc_filename
    echo
    echo "This will execute the main script, initiating the machine learning project." >> $doc_filename
    echo "For more detailed information, refer to the corresponding documentation and code comments." >> $doc_filename
    # Display information to the user
    echo " Professional documentation created (${doc_filename})."
    echo " For more detailed information, refer to the '${doc_filename}' file in your project directory. "
    echo
    echo
    echo "                                    ---------------------------------------------------------------------------------------------"
    echo "                                    - 👨‍ Author:                                                    Saad Alam                   -"
    echo "                                    - 🌐 Position:                                                  Machine Learning Engineer   -"
    echo "                                    - 🏢 Company:                                                   AxcelerateAI                -"
    echo "                                    ----------------------------------------------------------------------------------------------"
    echo
    echo
    echo "                               🚀 Your machine learning project structure for ${project_name} is ready! Time to unleash the power of AI! 🌟🚀 "
}


# Main script
read -p "📁 Enter the project name: " project_name

# Ask user for project directory path
read -p "📂 Enter the project directory path (or press Enter to use the current directory): " project_path_input
project_path_input=$(realpath "$project_path_input" 2>/dev/null)  # Convert to absolute path
if [ -z "$project_path_input" ]; then
    project_path=$(pwd)
else
    project_path="$project_path_input"
fi

# Install tree command
install_tree

# Create project directory
mkdir -p "$project_path/$project_name"
cd "$project_path/$project_name"

# Create data directory and subdirectories
mkdir -p data/raw data/processed data/interim data/external

# Create notebooks directory
mkdir notebooks

# Create src directory and subdirectories
mkdir -p src/data_preprocessing src/feature_engineering src/model src/evaluation src/utils

# Create models directory
mkdir models

# Create logs directory
mkdir logs

# Create reports directory
mkdir reports

# Create essential .py files
touch requirements.txt config.yml main.py

# Create virtual environment
create_virtualenv

# Create .gitignore file
create_gitignore

# Create essential Python files
touch src/model_train.py src/model_test.py src/model_detect.py make_dataset.py

# Create professional documentation
create_documentation

# Change working directory to the project directory
# Change working directory to the project directory
if cd "$project_path/$project_name"; then
    # If changing directory succeeds, activate virtual environment
    source "$project_path/$project_name/.env/bin/activate"
    
    # Rest of your script...
    # Any additional configurations or setups for your project

    # Test - Output current directory and check if the virtual environment is active
    pwd
    source  .env/bin/activate
    exec zsh
else
    # If changing directory fails, exit the script
    echo "Failed to change directory to $project_path/$project_name"
    exit 1
fi

# cd "$project_path/$project_name" || source .env/bin/activate || exit

# Activate virtual environment


# Call the function to change directory and activate virtual environment
#source .env/bin/activate

