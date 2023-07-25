# متغير يحدد مسار ملف السكربت لو وضعت داخل مجلد يحدد مسار ملف السكربت كامل
BASEDIR=$(dirname "$0")
# متغير لتحديد مسار المجلد
IPAIN="$BASEDIR"

# متغير لتحيد مجلد البرنامج بعد الانتهاء
Create_Folder="outIPA"

# تحديد مسار المجلد
cd $IPAIN

#انشاأ مجلد جديد
mkdir $Create_Folder

read -p " الرجاء اكتب اسم للبرنامج ويفضل انجليزي وبدون مسافات بن الكلمتين : " appName

cd $IPAIN

if [ "$appName" == "" ]; then
echo  " 🤨 لم تكتب شيء "
echo  " الرجاء اكتب اسم للبرنامج ويفضل انجليزي وبدون مسافات بن الكلمتين "

exit
fi

# حذف مجلد البرامج لاجل يتم انشائه من جديد
rm -r Payload
# فك الضغط عن البرنامج
unzip *.ipa
rm -r __MACOSX



APPLICATION=$(ls "$IPAIN/Payload/") 2>/dev/null

#/lproj/InfoPlist.strings
# حذف اسم البرنامج داخل مجلد اللغات
for dir in $IPAIN/Payload/$APPLICATION/*.lproj
do
  /usr/libexec/PlistBuddy -c "delete :CFBundleDisplayName" "${dir}/InfoPlist.strings"
  /usr/libexec/PlistBuddy -c "delete :CFBundleName" "${dir}/InfoPlist.strings"
done


# ضغط مجلد البرنامج
zip -r Payload.zip Payload 2>/dev/null

mv Payload.zip $appName.ipa 2>/dev/null
mv $appName.ipa $Create_Folder 2>/dev/null

rm -r Payload 2>/dev/null

echo " "

echo " تم الإنتهاء "
echo " برمجة نواف منصور "



