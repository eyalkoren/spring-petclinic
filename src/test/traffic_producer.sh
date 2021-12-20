# Change to the required PetClinic test app root
BASE_URL=http://localhost:8080

while :
do
        curl -s $BASE_URL > /dev/null
        curl -s $BASE_URL/owners\?lastName\= > /dev/null
        curl -s $BASE_URL/owners/1 > /dev/null
        curl -s $BASE_URL/owners/1/edit > /dev/null
        curl -s "firstName=George&lastName=Constansa&address=home&city=NY&telephone=1234567" \
                    -H "Content-Type: application/x-www-form-urlencoded" \
                    -X POST $BASE_URL/owners/1/edit > /dev/null
        curl -s "${BASE_URL}/owners/2?factorial=20000" > /dev/null
        curl -s $BASE_URL/owners/3 > /dev/null
        curl -s $BASE_URL/owners/4 > /dev/null
        curl -s $BASE_URL/owners/5 > /dev/null
        curl -s $BASE_URL/owners/6 > /dev/null
        curl -s $BASE_URL/oups > /dev/null
        curl -s $BASE_URL/vets.html > /dev/null
        curl -s "${BASE_URL}/vets.html?sleep=200" > /dev/null
        sleep 0.1
done
