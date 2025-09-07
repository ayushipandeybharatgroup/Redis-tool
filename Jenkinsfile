pipeline {
    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
        choice(name: 'action', choices: ['apply', 'destroy'], description: 'Select the action to perform')
    } 

    environment {
        AWS_DEFAULT_REGION = 'ap-south-1'
    }

    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git url: 'git@github.com:ayushipandeybharatgroup/Redis-tool.git', branch: 'main'
            }
        }

        stage('Terraform Init & Plan') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
                                  credentialsId: 'Aws_tool_cred']]) {
                    sh '''
                        cd terraform
                        terraform init
                        terraform validate
                        terraform plan
                    '''
                }
            }
        }

        stage('Apply/Destroy') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
                                  credentialsId: 'Aws_tool_cred']]) {
                    sh """
                        cd terraform
                        terraform ${params.action} ${params.autoApprove ? '--auto-approve' : ''}
                    """
                }
            }
        }

        stage('Sleep After Apply') {
            when {
                expression {
                    return params.action == 'apply'
                }
            }
            steps {
                echo "Sleeping for 10 seconds after terraform apply"
                sleep 10
            }
        }

        stage('Approve and Run Ansible Playbook') {
            when {
                expression {
                    return params.action == 'apply'
                }
            }
            steps {
                input message: 'Do you approve running the Ansible playbook?', ok: 'Yes'
                script {
                    echo "Running Ansible Playbook..."
                    sh 'ansible-playbook -i aws_ec2.yaml playbook.yml'
                }
            }
        }
    }
}
