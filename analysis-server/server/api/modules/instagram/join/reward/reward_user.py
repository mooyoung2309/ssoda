import server.secret.config as config


# 사용자 점수 계산 - 팔로워 수
def reward_user(follower_count) -> float:
    return follower_count / config.InstagramReward.FOLLOWER_NUMBER * 100
