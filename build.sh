#!/usr/bin/env bash

if [[ -z "${AGENT_VERSION}" ]];
then
  echo "AGENT_VERSION environment variable must be set"
  exit 1
else
  echo "AGENT_VERSION: ${AGENT_VERSION}"
fi

echo "Building Spring PetClinic from current directory..."
./mvnw -e -B package -DskipTests -Dcheckstyle.skip

mkdir app
cp target/spring-petclinic-*.jar app/app.jar

echo "Downloading Java agent version ${AGENT_VERSION}"
curl -L -o app/elastic-apm-agent.jar \
    "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=co.elastic.apm&a=elastic-apm-agent&v=${AGENT_VERSION}"

echo "Building Docker image"
docker build -t eyalkoren/pet-clinic:busy-method-with-agent .

rm -r agent
rm -r app
