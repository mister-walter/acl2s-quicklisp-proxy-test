FROM atwalter/acl2s:latest

ADD fix-quicklisp.pl /tmp/

RUN cd /tmp && \
        echo '$HTTP_PROXY' &&\
        curl -O https://beta.quicklisp.org/quicklisp.lisp && \
        sbcl --load quicklisp.lisp --quit --eval '(quicklisp-quickstart:install :proxy "$HTTP_PROXY")' &&\
        perl /tmp/fix-quicklisp.pl &&\
        sbcl --eval '(load "/root/quicklisp/setup.lisp")' --eval "(ql:add-to-init-file)"

RUN sbcl --eval '(ql:quickload :cl-json)'
CMD ["sbcl"]
