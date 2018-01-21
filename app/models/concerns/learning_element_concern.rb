module LearningElementConcern
  def unique_position_in_unit
    return unless self.unit.unit_learning_elements.pluck(:position_in_unit).include?(self.position_in_unit)
    errors.add(:position_in_unit, 'already taken')
  end

  def unique_exercise_position_in_unit
    return unless self.unit.unit_exercises.pluck(:position_in_unit).include?(self.position_in_unit)
    errors.add(:position_in_unit, 'already taken')
  end
end
