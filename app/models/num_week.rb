class NumWeek < ActiveHash::Base
  self.data = [
    { id: 1, name: '1周目' },
    { id: 2, name: '2周目' },
    { id: 3, name: '3周目' },
    { id: 4, name: '4周目' },
    { id: 5, name: '5周目' },

  ]
 
  include ActiveHash::Associations
  has_many :plans

end