WIP, stable-ish

---

HOCs

1. local modules && paths (per lang)
   1. src/???
   1. live reload for other kernels
   1. easy import
1. local tests && paths (per lang)
   1. tests/???

LOCs

1. port manager
1. Dockerfile clean up with comments
1. bin/test update to cover all langs
1. example notebook per lang
1. what up with the work dir? (side level as go)
1. add notebooks/untracked dir
1. gitignore update

@question requirements.txt (package.json, go.mod...?)

---

**@todo** port manager

example:

source data-python-template/bin/run.bash

```
# If the HOST_PORT is already in use, find the next open port to use in port mapping
# Note: This is necassary if you are running two instance of this template
#       in you local environment. Not the cleanest, but works.
while [[ ! -z $(lsof -i :$HOST_PORT) ]]
do
    echo "Important message from ${0##*/}"
    echo ">> Port $HOST_PORT in use. Looking for the next available port."
    echo ">> You will access notebooks from a different port other than $HOST_PORT"
    ((HOST_PORT++))
done

echo ">> Host port set to: $HOST_PORT, http://127.0.0.1:$HOST_PORT"
```

---

**@idea** https://cookiecutter.readthedocs.io/en/stable/usage.html

---

```
rm -rf notebooks/.* && bin/build.bash --no-cache && bin/run.bash
```

@todo handle use case if not
exmaple

```
➜  jupyter-runtime-template git:(main) ✗ rm -rf notebooks/.*
zsh: no matches found: notebooks/.*
```

```
rm -rf notebooks/.*
```

sudo rm -rf notebooks/go

```
sudo rm -rf notebooks/go.*
```

sudo rm notebooks/go.\*

bin/build.bash --no-cache && bin/run.bash

ls ~/.local/share/jupyter/kernels

---

<!-- mkdir -p $HOME/go/{bin,src} -->

---

/.local/share/jupyter/kernels/gophernotes/

---

```
[I 2023-05-11 00:59:56.869 ServerApp] 302 GET / (172.17.0.1) 0.59ms
[E 2023-05-11 00:59:57.452 ServerApp] Uncaught exception GET /lab/api/settings?1683766797224 (172.17.0.1)
    HTTPServerRequest(protocol='http', host='127.0.0.1:8888', method='GET', uri='/lab/api/settings?1683766797224', version='HTTP/1.1', remote_ip='172.17.0.1')
    Traceback (most recent call last):
      File "/opt/conda/lib/python3.8/site-packages/tornado/web.py", line 1704, in _execute
        result = await result
    tornado.iostream.StreamClosedError: Stream is closed
```

```
npm install -g ijavascript \
&& ijsinstall \
&& go install github.com/gopherdata/gophernotes@v0.7.5 \
&& mkdir -p ~/.local/share/jupyter/kernels/gophernotes \
&& cd ~/.local/share/jupyter/kernels/gophernotes \
&& cp "$(go env GOPATH)"/pkg/mod/github.com/gopherdata/gophernotes@v0.7.5/kernel/*  "." \
&& chmod +w ./kernel.json \
&& sed -i 's/gophernotes/\/home\/jovyan\/go\/bin\/gophernotes/g' ~/.local/share/jupyter/kernels/gophernotes/kernel.json
```

```
npm install -g ijavascript && ijsinstall \
&& go install github.com/gopherdata/gophernotes@v0.7.5 \
&& mkdir -p ~/.local/share/jupyter/kernels/gophernotes \
&& cp "$(go env GOPATH)"/pkg/mod/github.com/gopherdata/gophernotes@v0.7.5/kernel/* ~/.local/share/jupyter/kernels/gophernotes/ \
&& chmod +w ~/.local/share/jupyter/kernels/gophernotes/kernel.json \
&& sed -i 's/gophernotes/\/home\/jovyan\/go\/bin\/gophernotes/g' ~/.local/share/jupyter/kernels/gophernotes/kernel.json
```

clean, fresh jawn

if [ -f "$file" ];

```
sudo rm -rf notebooks/go \
&& bin/build.bash --no-cache \
&& bin/run.bash
```

```
rm -rf notebooks/.* && bin/build.bash --no-cache && bin/run.bash
```

handle `rm` https://www.darklaunch.com/bash-check-if-file-exists-one-liner-and-delete.html

---

could not import golang.org/x/mod/sumdb (cannot find package "golang.org/x/mod/sumdb" in any of
/usr/local/Cellar/go/1.18.3/libexec/src/golang.org/x/mod/sumdb (from $GOROOT)
/Users/jm/go/src/golang.org/x/mod/sumdb (from $GOPATH))

No packages found for open file /Users/jm/Workshop/jupyter-runtime-template/notebooks/go/pkg/mod/github.com/cosmos72/gomacro@v0.0.0-20220530072503-c719ab5c40fc/bench_sort_test.go: <nil>.
If this file contains build tags, try adding "-tags=<build tag>" to your gopls "buildFlags" configuration (see (https://github.com/golang/tools/blob/master/gopls/doc/settings.md#buildflags-string).

Otherwise, see the troubleshooting guidelines for help investigating (https://github.com/golang/tools/blob/master/gopls/doc/troubleshooting.md).

---

```
rm -rf notebooks/.* \
&& sudo rm -rf notebooks/go \
&& bin/build.bash --no-cache
```

@idea

https://docs.docker.com/build/building/multi-stage/

COPY --chown=patrick
https://stackoverflow.com/questions/28879364/docker-copy-and-change-owner

---

node \
&& --input-type=module \
&& --eval "import lodash from 'lodash-es'"

SyntaxError: Cannot use import statement inside the Node.js REPL, alternatively use dynamic import

(base) jovyan@1be1aa7d58ec:~/notebooks$ node --version
v17.9.0

babel?

https://stackoverflow.com/questions/74289336/jest-node-js-syntaxerror-cannot-use-import-statement-outside-a-module

jupyter kernelspec list

```
(base) jovyan@1791476b1bae:~/notebooks$ jupyter kernelspec list
Available kernels:
  gophernotes    /home/jovyan/.local/share/jupyter/kernels/gophernotes
  javascript     /home/jovyan/.local/share/jupyter/kernels/javascript
  python3        /opt/conda/share/jupyter/kernels/python3
```

CommonJS
const parse = require('node-html-parser');

---

[W 2023-05-17 23:56:26.397 ServerApp] 404 GET /api/kernels/b816bb72-d38d-4f97-8263-ec7ef0b15708?1684367786392 (172.17.0.1): Kernel does not exist: b816bb72-d38d-4f97-8263-ec7ef0b15708
[W 2023-05-17 23:56:26.398 ServerApp] wrote error: 'Kernel does not exist: b816bb72-d38d-4f97-8263-ec7ef0b15708'
[W 2023-05-17 23:56:26.398 ServerApp] 404 GET /api/kernels/b816bb72-d38d-4f97-8263-ec7ef0b15708?1684367786392 (172.17.0.1) 1.14ms referer=http://127.0.0.1:8888/lab/tree/notebooks/Untitled1.ipynb
[W 2023-05-17 23:56:26.642 ServerApp] 404 GET /api/kernels/b816bb72-d38d-4f97-8263-ec7ef0b15708/channels?session_id=54dbdd7d-ce46-4c87-8a21-d0b0c3cdd5df (172.17.0.1): Kernel does not exist: b816bb72-d38d-4f97-8263-ec7ef0b15708
[W 2023-05-17 23:56:26.655 ServerApp] 404 GET /api/kernels/b816bb72-d38d-4f97-8263-ec7ef0b15708/channels?session_id=54dbdd7d-ce46-4c87-8a21-d0b0c3cdd5df (172.17.0.1) 14.57ms referer=None
[W 2023-05-17 23:56:26.659 ServerApp] 404 GET /api/kernels/b816bb72-d38d-4f97-8263-ec7ef0b15708?1684367786655 (172.17.0.1): Kernel does not exist: b816bb72-d38d-4f97-8263-ec7ef0b15708
[W 2023-05-17 23:56:26.660 ServerApp] wrote error: 'Kernel does not exist: b816bb72-d38d-4f97-8263-ec7ef0b15708'
[W 2023-05-17 23:56:26.660 ServerApp] 404 GET /api/kernels/b816bb72-d38d-4f97-8263-ec7ef0b15708?1684367786655 (172.17.0.1) 0.88ms referer=http://127.0.0.1:8888/lab/tree/notebooks/Untitled1.ipynb
[E 2023-05-17 23:56:48.447 ServerApp] Uncaught exception GET /lab/api/settings?1684367808287 (172.17.0.1)
HTTPServerRequest(protocol='http', host='127.0.0.1:8888', method='GET', uri='/lab/api/settings?1684367808287', version='HTTP/1.1', remote_ip='172.17.0.1')
Traceback (most recent call last):
File "/opt/conda/lib/python3.8/site-packages/tornado/web.py", line 1704, in \_execute
result = await result
tornado.iostream.StreamClosedError: Stream is closed
[I 2023-05-17 23:56:51.068 LabApp] Build is up to date

---

(base) jovyan@1791476b1bae:~/notebooks$ npm -g list
/opt/conda/lib
├── configurable-http-proxy@4.5.3
├── corepack@0.10.0
├── ijavascript@5.2.1
└── npm@8.5.5

node -e "import { ayeoh } from './mjsbar.mjs'"

https://github.com/n-riesco/ijavascript/issues/210#issuecomment-827570265

---

(base) jovyan@2368bb6bef1e:~/notebooks$ ijskernel
KERNEL: ARGV: [ '/opt/conda/bin/node', '/opt/conda/bin/ijskernel' ]
Usage: node kernel.js [--debug] [--hide-execution-result] [--hide-undefined] [--protocol=Major[.minor[.patch]]] [--session-working-dir=path] [--show-undefined] [--startup-script=path] connection_file
/opt/conda/lib/node_modules/ijavascript/lib/kernel.js:195
throw e;
^

Error: Error: missing connection_file
at parseCommandArguments (/opt/conda/lib/node_modules/ijavascript/lib/kernel.js:187:19)
at Object.<anonymous> (/opt/conda/lib/node_modules/ijavascript/lib/kernel.js:46:14)
at Module.\_compile (node:internal/modules/cjs/loader:1099:14)
at Object.Module.\_extensions..js (node:internal/modules/cjs/loader:1153:10)
at Module.load (node:internal/modules/cjs/loader:975:32)
at Function.Module.\_load (node:internal/modules/cjs/loader:822:12)
at Function.executeUserEntryPoint [as runMain] (node:internal/modules/run_main:77:12)
at node:internal/main/run_main_module:17:47

Node.js v17.9.0
(base) jovyan@2368bb6bef1e:~/notebooks$

---

(base) jovyan@2368bb6bef1e:~/notebooks$ jupyter-lab --version
3.4.8
(base) jovyan@2368bb6bef1e:~/notebooks$ ijs --version
5.2.1

---

https://nteract.io/kernels

---

> import fs from 'fs'
> import fs from 'fs'
> ^^^^^^

Uncaught:
SyntaxError: Cannot use import statement inside the Node.js REPL, alternatively use dynamic import

>
