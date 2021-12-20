#!/usr/bin/env bash

mkdir app

AGENT_JAR=agent/elastic-apm-agent.jar
if [[ -f "${AGENT_JAR}" ]]; then
  echo "${AGENT_JAR} exists, using it"
  cp ${AGENT_JAR} app
else
  if [[ -z "${AGENT_VERSION}" ]]; then
    echo "${AGENT_JAR} not found, AGENT_VERSION environment variable must be set"
    exit 1
  else
    echo "Downloading agent version ${AGENT_VERSION}"
    curl -L -o app/elastic-apm-agent.jar \
      "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=co.elastic.apm&a=elastic-apm-agent&v=${AGENT_VERSION}"
  fi
fi

echo "Building Spring PetClinic from current directory..."
./mvnw -e -B package -DskipTests -Dcheckstyle.skip

cp target/spring-petclinic-*.jar app/app.jar

echo "Building Docker image based on the following files:"
for file in app/*
do
  echo "${file}"
done

docker build -t eyalkoren/pet-clinic:busy-method-with-agent .

rm -r app
