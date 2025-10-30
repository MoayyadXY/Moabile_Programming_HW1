allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Place Android build outputs under the Flutter project's top-level build/ folder to keep artifacts together
val sharedBuildDir = file("../build")
rootProject.buildDir = sharedBuildDir

subprojects {
    // Each module builds into build/<module-name>
    buildDir = File(rootProject.buildDir, name)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}
