import pandas as pd
import oracledb as orcl
from sqlalchemy import create_engine

# 오라클에서 만든 데이터베이스 테이블에다가 데이터를 삽입시키는 함수
def InsertData():
    escalator = pd.read_csv('escalator.csv') # 지하철역 에스컬레이터에 관한 정보가 있는 csv파일을 읽어서 저장시키는 변수
    elevator = pd.read_csv('elevator.csv') # 지하철역 엘리베이터에 관한 정보가 있는 csv파일을 읽어서 저장시키는 변수
    chairlift = pd.read_csv('chairlift.csv') # 지하철역 휠체어리프트에 관한 정보가 있는 csv파일을 읽어서 저장시키는 변수
    attraction = pd.read_csv('attraction.csv') # 서울시 구별로 인기 관광지 100개에 관한 정보가 있는 csv 파일을 읽어서 저장시키는 변수
    restaurant = pd.read_csv('restaurant.csv') # 서울시 구별로 인기 맛집 100개에 관한 정보가 있는 csv 파일을 읽어서 저장시키는 변수
    congestion = pd.read_csv('congestion.csv') # 서울시 30분 간격 지하철 혼잡도에 관한 정보가 있는 csv 파일을 읽어서 저장시키는 변수

    path = 'oracle+oracledb://bts:12345@localhost:1521/?service_name=xe' # 오라클 드라이버 경로를 저장시키는 변수
    engine = create_engine(path)
    orcl.init_oracle_client() # thin 드라이버에서 thick 드라이버로 변경

    # 에스컬레이터 데이터 삽입
    print("Connected to database successfully.")
    escalator.to_sql(
        name = 'ESCALATOR',
        con = engine,
        if_exists = 'append',
        index = False,
    )
    print("Data inserted successfully")

    # 엘리베이터 데이터 삽입
    print("Connected to database successfully.")
    elevator.to_sql(
        name = 'ELEVATOR',
        con = engine,
        if_exists = 'append',
        index = False,
    )
    print("Data inserted successfully")

    # 휠체어리프트 데이터 삽입
    print("Connected to database successfully.")
    chairlift.to_sql(
        name = 'CHAIRLIFT',
        con = engine,
        if_exists = 'append',
        index = False,
    )
    print("Data inserted successfully")

    # 관광지 데이터 삽입
    print("Connected to database successfully.")
    attraction.to_sql(
        name = 'ATTRACTION',
        con = engine,
        if_exists = 'append',
        index = False,
    )
    print("Data inserted successfully")

    # 맛집 데이터 삽입
    print("Connected to database successfully.")
    restaurant.to_sql(
        name = 'RESTAURANT',
        con = engine,
        if_exists = 'append',
        index = False,
    )
    print("Data inserted successfully")

    # 혼잡도 데이터 삽입
    print("Connected to database successfully.")
    congestion.to_sql(
        name = 'CONGESTION',
        con = engine,
        if_exists = 'append',
        index = False,
    )
    print("Data inserted successfully")

InsertData()