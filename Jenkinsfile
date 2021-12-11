pipeline
{
    agent {
        label 'OneS'
    }
    
    environment {
        envString = 'true'
    }
 
    post {
        always {
            allure includeProperties: false, jdk: '', results: [[path: 'out/syntax-check/allure'], [path: 'out/smoke/allure'], [path: 'build/tests/allure']]
            junit allowEmptyResults: true, testResults: 'out/syntax-check/junit/junit.xml'
            junit allowEmptyResults: true, testResults: 'out/smoke/junit/*.xml'
            junit allowEmptyResults: true, testResults: 'build/tests/junit/*.xml'
        }
    
        failure {
            bat "echo failure"
        }
        
        success {
            bat "echo success"      
        }
    }
    stages {

        stage("stage") {
            steps {
                bat " echo Сообщение из steps"
                bat " echo Переменная envString = ${envString}"
                script {
                    scannerHome = tool "sonar-scaner"
                }
            }
        }

        stage("Очистка отчетов") {
            steps {
                bat "chcp 65001\n del /Q /S allure-report" 
                bat "chcp 65001\n del /Q /S out"
            }
        }

        stage("Создание тестовой базы #2") {
            steps {
                bat "chcp 65001\n vrunner init-dev --dt \"D:\\Anatoly\\Bases\\Курс DevOps\\Backups\\s_2021-12-11_2015.dt\" --db-user Администратор --src src/cf"
            }
        }

        stage("Синтаксический контроль #2") {
            steps {
                bat "chcp 65001\n vrunner syntax-check"
            }
        }

        stage("Дымовые тесты #2") {
            steps {
                script {
                    try {
                        bat "chcp 65001\n vrunner xunit"
                    }
                    catch (Exception Exc) {
                        currentBuild.result = 'UNSTABLE'                    
                    }
                }
            }
        }

        stage("Модульные тесты") {
            steps {
                script {
                    try {
                        // комманда copy применена, т.к. после compileepf модуль обработки пустой
                        bat """chcp 65001
                        call vrunner compileepf tests tests
                        copy /Y "D:\\Anatoly\\Bases\\Курс DevOps\\Тест_ПростойТест.epf" "D:\\J\\workspace\\training\\tests\\Тест_ПростойТест.epf"
                        call runner xunit --settings ./env-tests.json"""
                    }
                    catch (Exception Exc) {
                        currentBuild.result = 'UNSTABLE'                    
                    }
                }
            }
        }

        stage("Тесты ванесса") {
            steps {
                script {
                    try {
                        bat "chcp 65001\n vrunner vanessa"
                    }
                    catch (Exception Exc) {
                        currentBuild.result = 'UNSTABLE'                    
                    }
                }
            }
        }

        stage("АПК") {
            steps {
                script {
                    try {
                        bat "chcp 65001\n runner run --ibconnection /FD:/Anatoly/Bases/АПК --db-user \"Администратор\" --db-pwd \"\" --ordinaryapp=1 --command \"acc.catalog=${WORKSPACE};acc.propertiesPaths=./tools/acc-export/acc.properties;\" --execute \"./tools/acc-export/acc-export.epf"
                    }
                    catch (Exception Exc) {
                        currentBuild.result = 'UNSTABLE'                    
                    }
                }
            }
        }

        stage("Сонаркуб") {
                steps {
                    script{
                        scannerHome = tool name: 'sonar-scaner', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
                    }
                withSonarQubeEnv ("sonar") {
                        bat "${scannerHome}/bin/sonar-scanner -D sonar.login=b89b97f044bec3c32aa884f4940b6d2e78ac7bce -D sonar.projectVersion=${BUILD_ID}"
                    }  
                }
            }

    }
}
