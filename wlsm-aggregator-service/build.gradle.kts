plugins {
	java
	alias(libs.plugins.spring.boot)
	alias(libs.plugins.spring.dependency.management)
}

group = "org.jesperancinha"
version = "0.0.1-SNAPSHOT"

java {
	sourceCompatibility = JavaVersion.VERSION_21
}

tasks.bootJar {
	archiveFileName.set("wlsm-aggregator-service.jar")
}

repositories {
	mavenCentral()
}

dependencies {
	implementation("org.springframework.boot:spring-boot-starter-webflux")
	implementation(libs.spring.boot.starter.data.r2dbc)
	implementation(libs.springdoc.openapi.starter.webflux.ui)
	implementation(libs.r2dbc.postgresql)
	runtimeOnly("org.postgresql:postgresql")
	testImplementation("org.springframework.boot:spring-boot-starter-test")
	testImplementation("io.projectreactor:reactor-test")
}

tasks.withType<Test> {
	useJUnitPlatform()
}
