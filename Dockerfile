FROM python:3-alpine

ARG USER_ID
ARG GROUP_ID

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN mkdir /app && mkdir /public
WORKDIR /app
COPY src /app


RUN addgroup  --gid $GROUP_ID -S app \
    && adduser --uid $USER_ID -S app -G app\
    && apk update \
    && apk add --no-cache postgresql-dev gcc python3-dev musl-dev \
    && pip install --no-cache-dir -r requirements.txt \
    && chown -R app:app /app \
    && chown -R app:app /public

USER app