pipeline {
    agent any
    
    environment {
        DOCKER_USERNAME = "akbar2339124"
        IMAGE_NAME = "devops-app"
        DOCKER_REGISTRY = "docker.io"
        BUILD_TAG = "${BUILD_NUMBER}"
    }
    
    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
        timeout(time: 30, unit: 'MINUTES')
        timestamps()
    }
    
    triggers {
        githubPush()  // Auto-trigger on GitHub push
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo "========== STAGE: CHECKOUT =========="
                checkout scm
                echo "✓ Code checked out from GitHub"
                echo "Branch: ${GIT_BRANCH}"
                echo "Commit: ${GIT_COMMIT}"
            }
        }
        
        stage('Validate') {
            steps {
                echo "========== STAGE: VALIDATE =========="
                sh '''
                    echo "Validating Dockerfile..."
                    test -f Dockerfile && echo "✓ Dockerfile found" || exit 1
                    
                    echo "Validating scripts..."
                    test -f system_health.sh && echo "✓ system_health.sh found" || exit 1
                    
                    echo "✓ All files validated"
                '''
            }
        }
        
        stage('Build Docker Image') {
            steps {
                echo "========== STAGE: BUILD =========="
                sh '''
                    echo "Building Docker image..."
                    docker build -t ${DOCKER_USERNAME}/${IMAGE_NAME}:${BUILD_TAG} .
                    docker tag ${DOCKER_USERNAME}/${IMAGE_NAME}:${BUILD_TAG} ${DOCKER_USERNAME}/${IMAGE_NAME}:latest
                    echo "✓ Image built: ${DOCKER_USERNAME}/${IMAGE_NAME}:${BUILD_TAG}"
                '''
            }
        }
        
        stage('Test Image') {
            steps {
                echo "========== STAGE: TEST =========="
                sh '''
                    echo "Running application test inside image..."
                    docker run --rm ${DOCKER_USERNAME}/${IMAGE_NAME}:${BUILD_TAG} bash system_health.sh
                    echo "✓ Application test passed"
                '''
            }
        }
        
        stage('Push to Docker Hub') {
            when {
                branch 'main'  // Only push from main branch
            }
            steps {
                echo "========== STAGE: PUSH =========="
                sh '''
                    echo "Pushing image to Docker Hub..."
                    docker push ${DOCKER_USERNAME}/${IMAGE_NAME}:${BUILD_TAG}
                    docker push ${DOCKER_USERNAME}/${IMAGE_NAME}:latest
                    echo "✓ Images pushed successfully"
                '''
            }
        }
        
        stage('Image Report') {
            steps {
                echo "========== STAGE: REPORT =========="
                sh '''
                    echo "Local Docker images:"
                    docker images | grep ${IMAGE_NAME}
                    echo ""
                    echo "Build artifacts created:"
                    echo "  - ${DOCKER_USERNAME}/${IMAGE_NAME}:${BUILD_TAG}"
                    echo "  - ${DOCKER_USERNAME}/${IMAGE_NAME}:latest"
                '''
            }
        }
    }
    
    post {
        success {
            echo "========== BUILD SUCCESSFUL =========="
            echo "Pipeline completed successfully!"
            echo "Image available at: docker.io/${DOCKER_USERNAME}/${IMAGE_NAME}:${BUILD_TAG}"
        }
        failure {
            echo "========== BUILD FAILED =========="
            echo "Check logs above for error details"
        }
        always {
            echo "Pipeline execution finnished"
	    echo "Build ID: ${BUILD_ID}"
        }
    }
}
