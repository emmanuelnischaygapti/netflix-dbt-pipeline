# Netflix DBT Masterclass Project

This is a data transformation pipeline built using **dbt (Data Build Tool)** and **Snowflake**, based on the Netflix MovieLens dataset.

## Architecture

The project implements a modern data stack architecture with three layers:

1. **Staging (`models/staging/`)**: Cleaned, 1-to-1 views of the raw data (movies, ratings, tags, etc.) extracted from Snowflake.
2. **Core (`models/dim/` and `models/fct/`)**: Normalized Dimension and Fact tables.
   - `fct_ratings` is implemented as an incremental model for efficient loading.
   - `dim_movies`, `dim_users`, `dim_genome_tags` represent business entities.
3. **Mart (`models/mart/`)**: Highly aggregated, business-ready tables for BI and analytics.
   - `mart_movie_releases` integrates dimension data with a static seed (`seed_movie_release_dates.csv`).

## Getting Started

1. Set up your Python virtual environment and install dependencies:
   ```bash
   python -m venv venv
   source venv/Scripts/activate  # Windows
   pip install dbt-snowflake==1.9.0
   ```
2. Configure your `profiles.yml` inside `~/.dbt/` or `.dbt/` (not committed to version control).
3. Run the project:
   ```bash
   dbt deps
   dbt seed
   dbt run
   dbt test
   ```
