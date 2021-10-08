package com.rocketdan.serviceserver.firebase.service;

import com.rocketdan.serviceserver.domain.user.User;
import com.rocketdan.serviceserver.domain.user.UserRepository;
import com.rocketdan.serviceserver.domain.user.pushToken.UserPushToken;
import com.rocketdan.serviceserver.domain.user.pushToken.UserPushTokenRepository;
import com.rocketdan.serviceserver.firebase.dto.UserPushTokenSaveRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@RequiredArgsConstructor
@Service
public class UserPushTokenService {
    private final UserPushTokenRepository userPushTokenRepository;
    private final UserRepository userRepository;

    @Transactional
    public void saveOrUpdate(String userId, UserPushTokenSaveRequestDto requestDto) {
        Optional<UserPushToken> optionalUserPushToken = userPushTokenRepository.findByUserId(userId);

        if (optionalUserPushToken.isPresent()) {
            UserPushToken userPushToken = optionalUserPushToken.get();
            userPushToken.updatePushToken(requestDto.getPushToken());
        } else {
            userPushTokenRepository.saveAndFlush(new UserPushToken(userId, requestDto.getPushToken()));
        }
    }

    @Transactional(readOnly = true)
    public UserPushToken findByUserId(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new IllegalArgumentException("해당 유저가 없습니다. id=" + userId));
        UserPushToken entity = userPushTokenRepository.findByUserId(user.getUserId()).orElseThrow(() -> new IllegalArgumentException("해당 유저의 Push Token이 없습니다. userId=" + userId));
        return entity;
    }
}
