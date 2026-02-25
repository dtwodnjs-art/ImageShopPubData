package com.project.config;

import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;

import com.project.common.security.CustomAccessDeniedHandler;
import com.project.common.security.CustomLoginSuccessHandler;

import jakarta.servlet.DispatcherType;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity(prePostEnabled = true, securedEnabled = true)
public class SecurityConfig {

   private final DataSource dataSource;
   private final UserDetailsService userDetailsService;

   public SecurityConfig(DataSource dataSource, UserDetailsService userDetailsService) {
      this.dataSource = dataSource;
      this.userDetailsService = userDetailsService;
   }

   @Bean
   SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

   
            // 1) CSRF
            http.csrf(csrf -> csrf.disable())

            // 2) 인가
            .authorizeHttpRequests(auth -> auth.dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ERROR)
                  .permitAll().requestMatchers("/accessError", "/login", "/logout", "/css/**", "/js/**", "/error")
                  .permitAll().requestMatchers("/board/**").authenticated().requestMatchers("/manager/**")
                  .hasRole("MANAGER").requestMatchers("/admin/**").hasRole("ADMIN").anyRequest().permitAll())

            // 3) 로그인
            .formLogin(form -> form.loginPage("/auth/login").loginProcessingUrl("/login") // PDF랑 동일하게 명시 (안 쓰면 기본도
                                                                        // /login 이긴 함)
                  .successHandler(authenticationSuccessHandler()).permitAll())

            // 4) 접근 거부(권한 부족 403)
            .exceptionHandling(ex -> ex.accessDeniedHandler(accessDeniedHandler()))

            // 5) remember-me (DB 저장 방식)
            .rememberMe(rm -> rm.key("zeus").tokenRepository(persistentTokenRepository())
                  .tokenValiditySeconds(60 * 60 * 24).userDetailsService(userDetailsService) // 중요: remember-me는
                                                                           // UserDetailsService
                                                                           // 필요
            )

            // 6) 로그아웃
            .logout(logout -> logout
                  // 로그아웃 처리 URL (POST /logout 요청 시 Spring Security가 처리)
                  .logoutUrl("/auth/logout")
                  // 로그아웃 성공 후 홈으로 리다이렉트 (alert 출력을 위해 쿼리 파라미터 전달)
                  .logoutSuccessUrl("/auth/login")
                  // HTTP 세션 무효화 (서버 세션 제거)
                  .invalidateHttpSession(true)
                  // SecurityContext 내 인증 정보 제거
                  .clearAuthentication(true)
                  // 세션 쿠키 삭제 (브라우저 측 JSESSIONID 제거)
                  .deleteCookies("JSESSIONID", "remember-me")
                  // 로그아웃 관련 URL은 모든 사용자 접근 허용
                  .permitAll());

      return http.build();
   }

   @Bean
   PasswordEncoder passwordEncoder() {
      return new BCryptPasswordEncoder();
   }

   @Bean
   AuthenticationSuccessHandler authenticationSuccessHandler() {
      return new CustomLoginSuccessHandler();
   }

   @Bean
   AccessDeniedHandler accessDeniedHandler() {
      return new CustomAccessDeniedHandler();
   }

   // remember-me 토큰을 DB(persistent_logins)에 저장
   @Bean
   PersistentTokenRepository persistentTokenRepository() {
      JdbcTokenRepositoryImpl repo = new JdbcTokenRepositoryImpl();
      repo.setDataSource(dataSource);
      return repo;
   }
}
