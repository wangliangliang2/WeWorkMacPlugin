#!/bin/bash

app_name="企业微信"
shell_path="$(dirname "$0")"
other_dir_path="${shell_path}/Other"
framework_path="${other_dir_path}/Products/Release"
app_path="/Applications/${app_name}.app"
framework_name="WeWorkMacPlugin.framework"
dylib_name="WeWorkMacPlugin"
app_bundle_path="${app_path}/Contents/MacOS"
app_executable_path="${app_bundle_path}/${app_name}"
app_executable_backup_path="${app_executable_path}_backup"
dylib_path="${app_bundle_path}/${framework_name}/${dylib_name}"

if [ ! -w "${app_path}" ]
then
echo -e "\n\n 请输入密码 ： "
sudo chown -R $(whoami) "${app_path}"
fi

if [ ! -f "${app_executable_backup_path}" ]
then
cp "${app_executable_path}" "${app_executable_backup_path}"
fi

cp -r "${framework_path}/${framework_name}" ${app_bundle_path}
rm -rf ${framework_path}/*

${other_dir_path}/insert_dylib --all-yes "${dylib_path}" "${app_executable_backup_path}" "${app_executable_path}"
