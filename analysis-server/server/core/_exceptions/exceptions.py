from rest_framework.exceptions import APIException


class PostUpdateOk(APIException):
    default_detail = 'Post update ok'
    status_code = 200
    default_code = 'OK_001'


class UserUpdateOk(APIException):
    default_detail = 'User update ok'
    status_code = 200
    default_code = 'OK_002'


# 클라이언트 에러
class PostIsPrivate(APIException):
    default_detail = 'Post is private'
    status_code = 406
    default_code = 'CLIENT_ERROR_001'


class PostIsDiffHashtag(APIException):
    default_detail = 'Post is different hashtag'
    status_code = 406
    default_code = 'CLIENT_ERROR_002'


# 서버 에러
class ProxyDenied(APIException):
    default_detail = 'Proxy is denied'
    status_code = 500
    default_code = 'SERVER_ERROR_001'


class CrawlDenied(APIException):
    default_detail = 'Crawl is denied'
    status_code = 500
    default_code = 'SERVER_ERROR_002'
