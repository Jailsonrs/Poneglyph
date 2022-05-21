FROM tensorflow/tensorflow
WORKDIR /projects
RUN apt-get -y update
RUN apt-get -y install r-base libzmq3-dev libcurl4-openssl-dev libssl-dev
RUN pip install sklearn numpy==1.21 umap-learn matplotlib shap pandas Flask xgboost selenium requests seaborn scrapy jupyter -U && pip install jupyterlab
RUN R -e "install.packages(c('repr', 'IRdisplay', 'IRkernel'), type = 'source', repos = 'https://cloud.r-project.org/'); library(IRkernel); IRkernel::installspec()"
EXPOSE 8080:8888
ENTRYPOINT ["jupyter", "lab","--ip=0.0.0.0","--allow-root"]