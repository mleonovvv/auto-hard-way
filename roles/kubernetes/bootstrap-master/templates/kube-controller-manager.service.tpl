[Unit]
Description=Kubernetes Controller Manager
Documentation=https://github.com/kubernetes/kubernetes

[Service]
ExecStart=/usr/local/bin/kube-controller-manager \
  --address=0.0.0.0 \
  --cluster-cidr=10.200.0.0/16 \
  --cluster-name=kubernetes \
  --cluster-signing-cert-file={{ pki_dir }}/ca/ca.pem \
  --cluster-signing-key-file={{ pki_dir }}/ca/ca-key.pem \
  --kubeconfig={{ kubernetes_conf_dir }}/kube-controller-manager.kubeconfig \
  --leader-elect=true \
  --root-ca-file={{ pki_dir }}/ca/ca.pem \
  --service-account-private-key-file={{ pki_dir }}/service-account-key.pem \
  --service-cluster-ip-range=10.32.0.0/24 \
  --use-service-account-credentials=true \
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
