from fastapi import FastAPI, HTTPException, Request
from pydantic import BaseModel
import logging
import time

# Set up logging for CloudWatch / Observability later
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger("etl_processor")

app = FastAPI(title="FinTech ETL Processor API", version="1.0.0")

class ETLPayload(BaseModel):
    batch_id: str
    records: list
    source: str

@app.get("/health")
def health_check():
    """Health check endpoint for Kubernetes/Docker."""
    return {"status": "healthy"}

@app.post("/process_data")
async def process_data(payload: ETLPayload):
    """
    Simulates an ETL data processing step.
    Accepts JSON, processes the records, and returns a summary.
    """
    logger.info(f"Received ETL batch {payload.batch_id} from {payload.source} containing {len(payload.records)} records.")
    
    start_time = time.time()
    
    # Simulating data transformation / processing
    processed_count = 0
    errors = 0
    
    for record in payload.records:
        # Simulate processing logic
        if isinstance(record, dict) and "amount" in record:
            processed_count += 1
        else:
            errors += 1
            logger.warning(f"Invalid record format in batch {payload.batch_id}: {record}")
            
    # Simulate processing delay
    time.sleep(0.5) 
    
    processing_time_ms = round((time.time() - start_time) * 1000, 2)
    
    logger.info(f"Completed batch {payload.batch_id}. Processed: {processed_count}, Errors: {errors}, Time: {processing_time_ms}ms")
    
    return {
        "batch_id": payload.batch_id,
        "status": "success" if errors == 0 else "partial_success",
        "processed_records": processed_count,
        "failed_records": errors,
        "processing_time_ms": processing_time_ms
    }
