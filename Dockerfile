# Assuming app is built and agent is downlnoaded to the agent folder

FROM openjdk:10
WORKDIR /app
COPY app/*.jar ./

CMD java -javaagent:/app/elastic-apm-agent.jar\
                                        -Dserver.port=${SERVER_PORT:-}\
                                        -Delastic.apm.application_packages=org.springframework.samples.petclinic\
                                        -Dserver.context-path=/petclinic/\
                                        -Dspring.messages.basename=messages/messages\
                                        -Dlogging.level.org.springframework=${LOG_LEVEL:-INFO}\
                                        -Dsecurity.ignored=${SECURITY_IGNORED:-/**}\
                                        -Dbasic.authentication.enabled=${AUTHENTICATION_ENABLED:-false}\
                                        -Dserver.address=${SERVER_ADDRESS:-0.0.0.0}\
                                        -Delastic.apm.service_name=${ELASTIC_APM_SERVICE_NAME:-spring-petclinic}\
                                        -Delastic.apm.service_version=${ELASTIC_APM_SERVICE_VERSION:-1.0.0}\
                                        -Delastic.apm.span_frames_min_duration=${ELASTIC_APM_SPAN_FRAMES_MIN_DURATION:-5ms}\
                                        -Delastic.apm.capture_body=${ELASTIC_APM_CAPTURE_BODY:-off}\
                                        -Delastic.apm.environment=production\
                                        -Delastic.apm.transaction_sample_rate=${ELASTIC_APM_SAMPLE_RATE:-1.0}\
                                        -Delastic.apm.verify_server_cert=${ELASTIC_APM_VERIFY_SERVER_CERT:-false}\
                                        -Delastic.apm.ignore_urls=/health,/metrics*,/jolokia\
                                        -Delastic.apm.log_file=/var/log/apps/apm-spring-petclinic\
                                        -Delastic.apm.enable_log_correlation=true\
                                        -jar /app/app.jar
