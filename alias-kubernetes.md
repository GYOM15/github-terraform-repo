# Kubectl Aliases (macOS)

Ce document décrit un ensemble d’aliases utiles pour `kubectl`, ainsi que la procédure pour les activer sur macOS (zsh).

---

##  Fichier d’aliases Kubernetes

Créer le fichier `~/.kubectl_aliases` :

```bash
touch ~/.kubectl_aliases
````

Ajouter le contenu suivant :

```bash
# Alias principal
alias k='kubectl'

# Get
alias kg='kubectl get'
alias kga='kubectl get all'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgd='kubectl get deployments'
alias kgn='kubectl get nodes'
alias kgns='kubectl get namespaces'

# Describe
alias kdp='kubectl describe pod'
alias kds='kubectl describe svc'
alias kdd='kubectl describe deployment'
alias kdn='kubectl describe node'

# Apply / Delete
alias kaf='kubectl apply -f'
alias kdel='kubectl delete'
alias kdelf='kubectl delete -f'

# Logs
alias klog='kubectl logs'
alias kloga='kubectl logs --all-containers=true'

# Exec
alias kex='kubectl exec -it'

# Context & namespace
alias kctx='kubectl config current-context'
alias kctxs='kubectl config get-contexts'
alias kctxu='kubectl config use-context'
alias kns='kubectl config set-context --current --namespace'

# Config
alias kconf='kubectl config view'
alias kconfm='kubectl config view --minify'

# Port-forward
alias kpf='kubectl port-forward'

# Rollout
alias kro='kubectl rollout'
alias kros='kubectl rollout status'
alias krou='kubectl rollout undo'
alias kroh='kubectl rollout history'

# Scale
alias kscale='kubectl scale'
```

---

##  Activer les aliases (macOS – zsh)

Ouvrir le fichier `~/.zshrc` :

```bash
nano ~/.zshrc
```

Ajouter à la fin :

```bash
# Kubectl aliases
[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases
```

Recharger la configuration :

```bash
source ~/.zshrc
```

---

##  Vérification

```bash
type k
# k is aliased to `kubectl`
```

---

##  Notes

* Ces aliases sont compatibles avec tous les clusters Kubernetes (EKS, GKE, AKS, kind, etc.)
* Aucun outil externe requis
* Peut être partagé tel quel dans un dépôt Git

---

##  Recommandation

Pour un usage avancé :

* auto-complétion kubectl
* kubectx / kubens
* outils comme k9s ou stern





