#!/bin/bash
# script to run pre-push to github, this script will carry out almost all the pre-push check commands, all excluding code coverage check, you could
# either just push to github and wait for the job to fail and copy all the failed lines for the code coverage check, come back here and run the
# bulk_ignore.py script, or use the ignore_files.py script if it's just one file or two you need to ignore

# or you could right click on the test folder and choose "Run 'All Tests' with Coverage" and it will run all the tests and give you the code coverage
# for each file, then open the files and for each one that has less than 100% coverage, paste (// coverage:ignore-file) at the top of the file
#minimum code coverage value
coverage_limit=100

exit_message() {
  echo -e "\e[1;31m 😅 Lintool failed.\n 🪛 Check the issues.\n 🐝 Run again.\e[0m"
  # remove this if you are running on Git bash and use exec "$SHELL" instead
  exit 0
  # use this if you are running on Git bash
  #  exec "$SHELL"
}
success_message() {
  echo -e "\e[1;32m 😅 Success.\n 🪛 No issues found.\e[0m"
  # shellcheck disable=SC2162
  read -p " 🐝 Do you want to commit? (y/n) " -n 1 -r

  if [[ $REPLY =~ ^[Yy]$ ]]; then
    read -p " 🐝 Enter commit message: " -r commit_message
    git add .
    git commit -m "🐝 $commit_message"
    git push
    # remove this if you are running on Git bash and use exec "$SHELL" instead
    exit 0
    # use this if you are running on Git bash
    # exec "$SHELL"
  fi
}
dart format --set-exit-if-changed lib test || exit_message

flutter analyze lib test || exit_message

flutter test -j 4 --no-pub --coverage --test-randomize-ordering-seed random || exit_message
coverage_output=$(./genhtml.perl coverage/lcov.info -o coverage/html) # | grep -Eoh '[0-9]+.[0-9]+%')

very_good test -j 4 --optimization --coverage --test-randomize-ordering-seed random || exit_message

echo "Starting coverage analysis..."
flutter test --coverage test || exit_message

regex="([0-9]+)\.[0-9]*%"
if [[ $coverage_output =~ $regex ]]; then
  coverage_value="${BASH_REMATCH[1]}"
  echo "Code Coverage is $coverage_value%"

  if [ "$coverage_value" -lt $coverage_limit ]; then
    echo "Code Coverage must be at least $coverage_limit%"
    exit_message
  fi
else
  echo "😅 Can't detect Code Coverage Value. Check it yourself."
fi

echo -e "\e[1;32m Ready to push!\e[0m 🚀"

success_message
