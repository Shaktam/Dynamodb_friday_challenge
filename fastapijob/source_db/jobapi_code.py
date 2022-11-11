### 1. Setup Fast api
## 1. Setup fastapi to return jobs with id, title and description
# 1. "/job" a list of jobs 
# 1. "/job/:id" "single job matching the id

from http.client import HTTPException
from fastapi import FastAPI
import uvicorn
from s3_jobdata import get_job_data, list_job

app =FastAPI()

@app.get("/")
def health():
    return {"health": "OK"}    

@app.get("/job")
def getJobs():
    jobs = []
    for jobname in list_job():
        jobs.append(get_job_data(jobname))
    return jobs

@app.get("/job/{id}")
def joblist(id):
    try:
        return get_job_data(id)
    except Exception:     
        raise HTTPException(status_code=404,detail="Job with id" + id + "not found")         

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=80)