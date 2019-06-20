pipeline {
  agent {
    label 'java'
  }
  parameters {
    credentials credentialType: 'org.jenkinsci.plugins.plaincredentials.impl.StringCredentialsImpl', defaultValue: 'acp-dev-jenkins-url', description: '', name: 'jenkinsUrl', required: true
    credentials credentialType: 'com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl', defaultValue: 'acp-dev-jenkins-user', description: '', name: 'jenkinsUser', required: true
  }
  stages {
    stage('kubernetes-support') {
      environment {
        JENKINS_URL = param.jenkinsUrl.value
        JENKINS_USER = param.jenkinsUser.userName
        JENKINS_TOKEN = param.jenkinsUser.password
      }
      steps {
        echo env.JENKINS_URL
        checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [],
            submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/alauda/alauda-kubernetes-support-plugin']]])
        sh 'mvn clean install -DskipTests && ./upload.sh alauda-kubernetes-support-plugin/target/alauda-kubernetes-support.hpi'
      }
    }
    stage('credentials-provider') {
      steps {
        checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [],
            submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/alauda/alauda-devops-credentials-provider-plugin']]])
        sh 'mvn clean install -DskipTests && ./upload.sh alauda-devops-credentials-provider-plugin/target/alauda-devops-credentials-provider.hpi'
      }
    }
    stage('devops-pipeline') {
      steps {
        checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [],
            submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/alauda/alauda-devops-pipeline-plugin']]])
        sh 'mvn clean install -DskipTests && ./upload.sh alauda-devops-pipeline-plugin/target/alauda-devops-pipeline.hpi'
      }
    }
    stage('devops-sync') {
      steps {
        checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [],
            submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/alauda/alauda-devops-sync-plugin']]])
        sh 'mvn clean install -DskipTests && ./upload.sh alauda-devops-sync-plugin/target/alauda-devops-sync.hpi'
      }
    }
    stage('restart') {
      environment {
        JENKINS_URL = param.jenkinsUrl.value
        JENKINS_USER = param.jenkinsUser.userName
        JENKINS_TOKEN = param.jenkinsUser.password
      }
      steps {
          sh 'echo restart'
      }
    }
  }
}