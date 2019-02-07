[Unit]
Description=Kubernetes API Server
Documentation=https://github.com/kubernetes/kubernetes

[Service]
ExecStart=/usr/local/bin/kube-apiserver \
  --advertise-address={{ KUBERNETES_PUBLIC_ADDRESS }} \
  --allow-privileged=true \
  --apiserver-count={{ groups['masters']|length }} \
  --audit-log-maxage=30 \
  --audit-log-maxbackup=3 \
  --audit-log-maxsize=100 \
  --audit-log-path=/var/log/audit.log \
  --authorization-mode=Node,RBAC \
  --bind-address=0.0.0.0 \
  --client-ca-file={{ pki_dir }}/ca/ca.pem \
  --enable-admission-plugins=Initializers,NamespaceLifecycle,NodeRestriction,LimitRanger,ServiceAccount,DefaultStorageClass,ResourceQuota \
  --enable-swagger-ui=true \
  --etcd-cafile={{ pki_dir }}/ca/ca.pem \
  --etcd-certfile={{ pki_dir }}/kubernetes.pem \
  --etcd-keyfile={{ pki_dir }}/kubernetes-key.pem \
  --etcd-servers={% for i in groups['masters']  %}https://{{ hostvars[i].ansible_host }}:2379{{ "," if not loop.last else "" }}{% endfor %} \
  --event-ttl=1h \
  --experimental-encryption-provider-config={{ kubernetes_conf_dir }}/encryption-config.yaml \
  --kubelet-certificate-authority={{ pki_dir }}/ca/ca.pem \
  --kubelet-client-certificate={{ pki_dir }}/kubernetes.pem \
  --kubelet-client-key={{ pki_dir }}/kubernetes-key.pem \
  --kubelet-https=true \
  --runtime-config=api/all \
  --service-account-key-file={{ pki_dir }}/service-account.pem \
  --service-cluster-ip-range=10.32.0.0/24 \
  --service-node-port-range=30000-32767 \
  --tls-cert-file={{ pki_dir }}/kubernetes.pem \
  --tls-private-key-file={{ pki_dir }}/kubernetes-key.pem \
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
