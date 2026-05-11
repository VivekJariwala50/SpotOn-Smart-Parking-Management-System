pipeline {
    agent any

    environment {
        APP_NAME    = "spoton-smart-parking"
        CONTAINER   = "spoton-dev"
        APP_PORT    = "8000"
        NETWORK     = "spoton-network"
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Checking out source code..."
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo "Building Docker image: ${APP_NAME}:dev"
                sh "docker build -t ${APP_NAME}:dev ."
            }
        }

        stage('Test') {
            steps {
                echo "Running test suite..."
                sh """
                    docker run --rm \
                        -e SECRET_KEY=ci-secret \
                        -e FLASK_ENV=testing \
                        ${APP_NAME}:dev \
                        pytest tests/ -v --tb=short
                """
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying container..."
                sh """
                    # Stop and remove any existing container
                    docker stop ${CONTAINER} || true
                    docker rm -f ${CONTAINER} || true

                    # Ensure shared network exists
                    docker network create ${NETWORK} || true

                    # Start database container if not already running
                    docker start postgres-db || true

                    # Run application container
                    docker run -d \
                        --name ${CONTAINER} \
                        --network ${NETWORK} \
                        -p ${APP_PORT}:${APP_PORT} \
                        -e DATABASE_URL=postgresql://admin:admin@postgres-db:5432/parking \
                        -e SECRET_KEY=\${SECRET_KEY} \
                        ${APP_NAME}:dev
                """
            }
        }
    }

    post {
        success {
            echo "========================================================"
            echo " SpotOn is live at http://localhost:${APP_PORT}"
            echo "========================================================"

            withCredentials([string(credentialsId: 'SLACK_WEBHOOK', variable: 'SLACK_WEBHOOK')]) {
                sh """
                    curl -s -X POST -H 'Content-type: application/json' \\
                    --data '{"text":"✅ Jenkins Build #${env.BUILD_NUMBER} — SpotOn deployed successfully\\nURL: http://localhost:${APP_PORT}"}' \\
                    "\$SLACK_WEBHOOK"
                """
            }
        }

        failure {
            echo "Build #${env.BUILD_NUMBER} FAILED."

            withCredentials([string(credentialsId: 'SLACK_WEBHOOK', variable: 'SLACK_WEBHOOK')]) {
                sh """
                    curl -s -X POST -H 'Content-type: application/json' \\
                    --data '{"text":"❌ Jenkins Build #${env.BUILD_NUMBER} FAILED — SpotOn pipeline encountered an error."}' \\
                    "\$SLACK_WEBHOOK"
                """
            }
        }

        always {
            echo "Pipeline finished."
        }
    }
}
