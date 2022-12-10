### BUILDER 

FROM python:3.9.6-alpine as builder

WORKDIR /usr/src/main

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apk update && \
    apk add gcc libc-dev libffi-dev && \
    apk add postgresql-dev python3-dev musl-dev


COPY ./requirements.txt .
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /usr/src/main/wheels -r requirements.txt


### FINAL

FROM python:3.9.6-alpine

RUN mkdir -p /home/dscantool

RUN addgroup -S dscantool && adduser -S dscantool -G dscantool

ENV HOME=/home/dscantool
ENV APP_HOME=/home/dscantool/web
RUN mkdir $APP_HOME
RUN mkdir $APP_HOME/staticfiles

WORKDIR $APP_HOME
RUN apk update && apk add libpq
COPY --from=builder /usr/src/main/wheels /wheels
COPY --from=builder /usr/src/main/requirements.txt .
RUN pip install --no-cache /wheels/*

COPY ./entrypoint.sh .
RUN sed -i 's/\r$//g' $APP_HOME/entrypoint.sh
RUN chmod +x $APP_HOME/entrypoint.sh

COPY . $APP_HOME

RUN chown -R dscantool:dscantool $APP_HOME 

USER dscantool

ENTRYPOINT ["/home/dscantool/web/entrypoint.sh"]
