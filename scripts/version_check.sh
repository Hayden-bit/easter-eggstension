git clone -b dev https://github.com/andreaskth/easter-eggstension.git 
new=$( jq ".version" extension/manifest.json | cut -d '"' -f 2)
old=$( jq ".version" easter-eggstension/extension/manifest.json | cut -d '"' -f 2)
echo "Old: ${old}"
echo "New: ${new}"

first=$(( $( echo "${old}" | cut -d '.' -f 1) > $( echo "${new}" | cut -d '.' -f 1) ))
if (( $? == 1 )); then
  exit 1
fi
# Pairs of comparisons, so if the first does not fail the second shouldn’t either
second=$(( $( echo "${old}" | cut -d '.' -f 1) < $( echo "${new}" | cut -d '.' -f 1) ))
third=$(( $( echo "${old}" | cut -d '.' -f 2) > $( echo "${new}" | cut -d '.' -f 2) ))
if (( $? == 1 )); then
  exit 1
fi
forth=$(( $( echo "${old}" | cut -d '.' -f 2) < $( echo "${new}" | cut -d '.' -f 2) ))
fifth=$(( $( echo "${old}" | cut -d '.' -f 3) >= $( echo "${new}" | cut -d '.' -f 3) ))
if (( $? == 1 )); then
  exit 1
fi

if (( $first )); then
  exit 1
elif (( $second )); then
  exit 0
elif (( $third )); then
  exit 1
elif (( $forth )); then
  exit 0
elif (( $fifth )); then
   exit 1
else
   exit 0
fi
