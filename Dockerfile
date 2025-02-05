FROM nginx:latest
COPY index.html /usr/share/nginx/html
EXPOSE 60
CMD ["nginx", "-g", "daemon off;"]
