apiVersion: kubescheduler.config.k8s.io/v1alpha1
kind: KubeSchedulerConfiguration
clientConnection:
  kubeconfig: "{{ kubernetes_conf_dir }}/kube-scheduler.kubeconfig"
leaderElection:
  leaderElect: true
