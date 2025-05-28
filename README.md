
![marong](https://github.com/user-attachments/assets/a5025e5d-5c3e-4e91-94c3-e7afa4e6e0ca)

# 1. Overview

---

- 프로젝트 이름 : Marrong
- 프로젝트 설명 : 마니또 기반 SNS 서비스

# 2. Members

---

| Noah(문현민) | Trent(곽용우) |
| --- | --- |
| 이미지  | 이미지 |
| Cloud | Cloud |
| [Github](https://github.com/moonhyeonmin) | [Github](https://github.com/kwakyongwoo) |

# 3. Task & Responsibilities

---

|  |  |  |
| --- | --- | --- |
| Noah | 프사 | Cloud 배포 및 관리, CI/CD  관리 |
| Trent | 프사 | Cloud 배포 및 관리, CI/CD  관리 |

# 4. Cloud Architecture

---

### ☁️ V1

---

![스크린샷 2025-03-17 오전 9.14.56.png](/images/V1.png)

- AWS EC2 빅뱅 배포
    - EC2 사용 스펙 : 어쩌구
- JAR, VITE로 아카이빙하여 배포
    - 어쩌구

### ☁️ V2

---

![image.png](/images/2.png)

- Google Cloud Platform(GCP)를 사용한 3-Tier 배포
    - 스펙 1
    - 스펙 2
- Shared, Dev, Prod 서버 구분
    - Shared
        - 외부와의 통신을 위한 Bastion 서버
        - OpenVPN
    - Dev
        - 개발자가 코드를 자유롭게 변경하고 실험할 수 있는 환경
        - 개발 중인 기능에 대한 초기 테스트
        - 실제 사용자 데이터 대신 테스트 데이터 사용
    - Prod
        - 실제 사용자에게 서비스를 제공하는 환경
        - 실제 사용자 데이터를 처리하고 저장
        - 변경사항은 Dev에서의 철저한 테스트와 검증 과정을 거친 후 적용
        - 소프트웨어의 최종 버전 배포

### ☁️ V3

---

![image.png](/images/3.png)

- MSA 구조 배포
    - AWS EKS 사용
    - Pod 1
    - Pod 2

# 5. Tools

---

### 5.1 Release

---

| | |
| --- | --- |
| AWS | ![](/images/aws.png) |
| GCP | ![](/images/gcp.png) |
| Terraform | ![](/images/terraform.png) |

### 5.2 CI/CD

---

|  | |
| --- | --- |
| Github Actions | ![](/images/gitHubactions.png) |
| CodeDeploy | ![](/images/codedeploy.png) |
| ArgoCD | ![](/images/ArgoCD.png) |

### 5.3 Cooperation

---

| | |
| --- | --- |
| Git | ![](/images/git.png) |
| Figjam | ![](/images/figma.png) |

# 6. Project Structure

---

```bash
project/
├── modules/                # 재사용 가능한 Terraform 모듈
│   ├── vpc/
│   ├── ec2/
│   ├── rds/
│   └── s3/
├── dev/                    # 개발 환경 인프라 설정
│   └── main.tf
├── prod/                   # 운영 환경 인프라 설정
│   └── main.tf
├── terraform.tfvars        # 변수 정의
└── README.md
```

# 7. Development Workflow

---

### Branch Strategy

---

<aside>
📌

Git-Flow를 기반으로 진행하며, 다음과 같은 브랜치를 사용함

</aside>

![image.png](/images/gitflow.png)

- **main**
    - 배포 가능한 상태의 코드를 유지
    - 모든 배포는 `main`에서 이루어짐
- **develop**
    - 다음 출시 버전을 대비하여 개발
- **feature**
    - 추가 기능 개발
    - `develop`에서 분기
- **release**
    - 다음 버전을 준비
    - `develop` → `release` 로 옮긴 후 QA, 테스트 진행 완료 시 `main`으로 merge
- **hotfix**
    - `main`에서 발생한 버그를 수정

# 8. Coding Convetion

---

### 명명 규칙

---

- 상수 : 영문 대문자 + snake_case

```jsx
const NAME_ROLE;
```

- 변수 & 함수 : camelCase

```jsx
// state
const [isLoading, setIsLoading] = useState(false);
const [isLoggedIn, setIsLoggedIn] = useState(false);
const [errorMessage, setErrorMessage] = useState('');
const [currentUser, setCurrentUser] = useState(null);

// 배열 - 복수형 이름 사용
const datas = [];

// 정규표현식: 'r'로 시작
const = rName = /.*/;

// 이벤트 핸들러: 'on'으로 시작
const onClick = () => {};
const onChange = () => {};

// 반환 값이 불린인 경우: 'is'로 시작
const isLoading = false;

// Fetch함수: method(get, post, put, del)로 시작
const getEnginList = () => {...}
```

### 블록 구문

---

```jsx
// 한 줄짜리 블록일 경우라도 {}를 생략하지 않고, 명확히 줄 바꿈 하여 사용한다
// good
if(true){
  return 'hello'
}

// bad
if(true) return 'hello'
```

### 폴더, 파일 네이밍

---

kebab-case를 기본으로 함

```bash
// kebab-case
noah-good
```

# 9. Commit Convention

---

### 기본 구조

---

```bash
type : subject (#Issue Number)
- 상세 내용
```

### type

---

```bash
feat : 새로운 기능 추가
fix : 버그 수정
docs : 문서 수정
style : 코드 포맷팅, 세미콜론 누락, 코드 변경이 없는 경우
design : 사용자 UI 디자인 변경 (CSS 등)
refactor : 코드 리팩토링
test : 테스트 코드, 리펙토링 테스트 코드 추가
build : 빌드 파일 수정
ci : CI 설정 파일 수정
perf : 성능 개선
chore : 빌드 업무 수정, 패키지 매니저 수정
rename : 파일 혹은 폴더명을 수정만 한 경우
remove : 파일을 삭제만 한 경우
```

### commit example

---

```bash
feat: 회원 가입 기능 구현(#1)
- 카카오 O-Auth 로그인 구현
```

# 10. Issue Convetion

---

```markdown
---
name: Feature request
about: 구현할 기능을 이슈에 등록
title: "[TAG] 이슈의 제목을 입력"
labes: "
assignees: "

---

## 🚀 구현 기능

## ✅ 상세 작업
- [] To-do 1
- [] To-do 2
- [] To-do 3

## 📄 참고 사항
```
