package com.rocketdan.serviceserver.Exception;

import lombok.Getter;

@Getter
public enum ErrorCode {
    // 로그인
    AUTHENTICATION_FAILED(401, "AUTH001", " AUTHENTICATION_FAILED."),
    LOGIN_FAILED(401, "AUTH002", " LOGIN_FAILED."),
    INVALID_JWT_TOKEN(401, "AUTH003", "INVALID_JWT_TOKEN."),
    INVALID_ACCESS_TOKEN(401, "AUTH004", "INVALID_ACCESS_TOKEN."),
    INVALID_REFRESH_TOKEN(401, "AUTH005", "INVALID_REFRESH_TOKEN."),
    NO_EXPIRED_TOKEN_YET(403, "AUTH006", "NO_EXPIRED_TOKEN_YET."),
    // file 처리
    FILE_UPLOAD_FAILED(500, "FILE001", "FILE_UPLOAD_FAILED."),
    FILE_CONVERT_FAILED(500, "FILE002", "FILE_CONVERT_FAILED."),
    // 이벤트 참여
    DUPLICATE_POST_URL(403, "EVENT_JOIN001", "DUPLICATE_POST_URL."),
    JOIN_EVENT_FAILED(403, "EVENT_JOIN002", "JOIN_EVENT_FAILED."),
    // Analysis server
    ANALYSIS_SERVER_ERROR(500, "ANALYSIS001", "ANALYSIS_SERVER_ERROR."),
    // 불법적인 리소스 접근
    NO_AUTHORITY(403, "AUTHORITY001", "NO_AUTHORITY_TO_RESOURCE.");


    private final String code;
    private final String message;
    private int status;

    ErrorCode(final int status, final String code, final String message) {
        this.status = status;
        this.message = message;
        this.code = code;
    }
}
