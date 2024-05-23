# Налаштування моніторингового стеку для вашого проєкту
### Огляд

Цей документ надає інструкції з налаштування моніторингового стеку для вашого проєкту в середовищі розробки Kubernetes. Моніторинговий стек включає такі компоненти:
- OpenTelemetry
- Prometheus
- Fluent Bit
- Grafana Loki
- Grafana

Стек розгорнуто та налаштовано в середовищі dev вашого кластера Kubernetes. OpenTelemetry розгорнуто за допомогою оператора. Fluent Bit збирає та експортує логи з вашого проєкту та всіх вузлів кластера.
### Передумови

Перш ніж розгортати моніторинговий стек, переконайтеся, що виконані наступні передумови:

- Доступ до кластера Kubernetes з достатніми дозволами для створення ресурсів.
- Встановлена та налаштована командна інтерфейсна утиліта kubectl для підключення до кластера Kubernetes.

### Кроки розгортання
1. Розгорнути OpenTelemetry Operator
Спершу потрібно встановити менеджер сертифікатів, для роботи OpenTelemetry Operator
```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.5/cert-manager.yaml
```

Після озгорніть OpenTelemetry Operator на вашому кластері Kubernetes:

```bash
kubectl apply -f https://github.com/open-telemetry/opentelemetry-operator/releases/download/v0.100.0/opentelemetry-operator.yaml
```

2. Розгорнути Prometheus

Розгорніть Prometheus для збору метрик:

```bash
kubectl apply -f deploy/prometheus/prometheus.yaml
```

Переконайтеся, що Prometheus налаштовано для збору метрик з контейнерів вашого додатка.
3. Розгорнути Fluent Bit

Розгорніть Fluent Bit для збору та експорту логів

```bash
kubectl apply -f deploy/prometheus/fluentbit.yaml
```

4. Розгорнути Grafana Loki

Розгорніть Grafana Loki для агрегації логів:

```bash
kubectl apply -f deploy/prometheus/loki.yaml
```

5. Розгорнути Grafana

Розгорніть Grafana для візуалізації:

```bash
kubectl apply -f deploy/prometheus/grafana.yaml
```

6. Налаштуйте доступ до Grafana
За допомогою Port-forwarding
```bash
kubectl port-forward -n dev <grafana-pod> 8080:3000
```
Або за допомогою LoadBanacer
```yaml
apiVersion: v1
kind: Service
metadata:
  name: grafana
  namespace: dev
spec:
  selector:
    app: grafana
  ports:
    - protocol: TCP
      port: 80
      targetPort: 3000
  type: LoadBalancer
```

## Демонстрація
![Grafana Dashboard](./Grafana_dashbord.gif)
