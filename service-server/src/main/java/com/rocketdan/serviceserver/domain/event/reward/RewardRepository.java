package com.rocketdan.serviceserver.domain.event.reward;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RewardRepository extends JpaRepository <Reward, Long> {
}