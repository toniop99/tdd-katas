#!/bin/bash

#Get directory of the script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_DIRECTORY="$SCRIPT_DIR/../projects"

# Get project name as argument
PROJECT_NAME=$1

PROJECT_NAME_PASCAL_CASE=$(echo "$PROJECT_NAME" | perl -nE 'say join "", map {ucfirst lc} split /[^[:alnum:]]+/')
PROJECT_NAME_WITHOUT_HYPHENS=$(echo "$PROJECT_NAME" | tr '-' ' ')

PROJECT_PATH="$PROJECT_DIRECTORY/$1"

# Check if project path exists and exit if it does
if [ -d "$PROJECT_PATH" ]; then
    echo "Project $PROJECT_NAME already exists!"
    exit 1
fi

# Create project directory
mkdir "$PROJECT_PATH"

# Create src directory and its subdirectories
mkdir "$PROJECT_PATH/src"
mkdir "$PROJECT_PATH/src/Solution"

# Create empty .gitkeep file inside Solution directory
touch "$PROJECT_PATH/src/Solution/.gitkeep"

# Create Kata.php file inside src directory
touch "$PROJECT_PATH/src/Kata.php"

sed "s|PROJECT_NAME_PASCAL_CASE|$PROJECT_NAME_PASCAL_CASE|g;" ./stubs/Kata.php.stub > "$PROJECT_PATH/src/Kata.php"

# Create tests directory and KataTest.php file inside it
mkdir "$PROJECT_PATH/tests"
mkdir "$PROJECT_PATH/tests/Solution"
touch "$PROJECT_PATH/tests/Solution/.gitkeep"

sed "s|PROJECT_NAME_PASCAL_CASE|$PROJECT_NAME_PASCAL_CASE|g;" ./stubs/KataTest.php.stub > "$PROJECT_PATH/tests/KataTest.php"

# Create composer.json file
sed "s|PROJECT_NAME_PASCAL_CASE|$PROJECT_NAME_PASCAL_CASE|g; s|PROJECT_NAME|$PROJECT_NAME|g;" ./stubs/composer.json.stub > "$PROJECT_PATH/composer.json"

# Create phpunit.xml file
cp ./stubs/phpunit.xml.stub "$PROJECT_PATH/phpunit.xml"

# Copy README.md.stub content to README.md and replace PROJECT_NAME with $PROJECT_NAME variable content
sed "s|PROJECT_NAME|$PROJECT_NAME_WITHOUT_HYPHENS|g;" ./stubs/README.md.stub > "$PROJECT_PATH/README.md"

echo "Project structure for $PROJECT_NAME generated successfully!"
exit 0