plugins {
    id("org.gradle.toolchains.foojay-resolver-convention") version "1.0.0"
}
rootProject.name = "wild-life-safety-monitor"
include("wlsm-aggregator-service")
include("wlsm-collector-service")
include("wlsm-listener-service")
include("wlsm-management-service")
include("wlsm-rest-client")
include("wlsm-messenger-service")
include("wlsm-messenger-protos")
include("wlsm-messenger-client")
