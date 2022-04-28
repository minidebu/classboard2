## users　table
| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
| email                 | string      | null: false ,unique: true      |
| encrypted_password    | string      | null: false                    |


## student table
| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
| name                  | string      | null: false                    |
| birth_on              | date        | null: false                    |
| withdrawal_on         | date        |                                |

### Association
- has_many :plans
- has_many :event_student


## plan table
| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
| week                  | string      | null: false                    |
| num_week_id           | integer     | null: false                    |
| time_id               | time        | null: false                    |
| started_on            | date        | null: false                    |
| update_on             | date        |                                |
| student               | references  | null: false ,foreign_key: true |
| lesson                | references  | null: false ,foreign_key: true |

### Association
- belongs_to :student
- belongs_to :lesson
- has_many :cancel_logs  


## lesson table
| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
| name                  | string      | null: false                    |

### Association
- has_many :plans
- has_many :transfer_log

## transfer_log table
| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
| transfer_at           | datetime    | null: false                    |
| lesson                | references  | null: false ,foreign_key: true |
| cancel_log            | references  | null: false ,foreign_key: true |

### Association
- belongs_to :cancel_log
- belongs_to :lesson


## cancel_log table
| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
| cancel_at             | datetime    | null: false                    |
| cancel_reason         | text        |                                |
| is_transfer           | boolean     | null: false                    |
| plan                  | references  | null: false ,foreign_key: true |

### Association
- belongs_to :plan
- has_one :transfer_log

## event_student table
| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
| event                 | references  | null: false ,foreign_key: true |
| student               | references  | null: false ,foreign_key: true |

### Association
- belongs_to :event
- belongs_to :student

## event table
| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
| name                  | string      | null: false ,foreign_key: true |
| started_at            | datetime    | null: false ,foreign_key: true |

### Association
- has_many :event_student

