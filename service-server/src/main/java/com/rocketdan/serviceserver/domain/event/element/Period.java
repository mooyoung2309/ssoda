package com.rocketdan.serviceserver.domain.event.element;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class Period {
    // 이벤트 영구 유지 여부
    private Boolean permanent;

    // 이벤트 시작 시간
    private String start;

    // 이벤트 끝 시간
    private String end;
}
