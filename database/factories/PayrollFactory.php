<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Payroll>
 */
class PayrollFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            // 'school_id'  => School::pluck('id')->random(),
            'payrollno'  => 'PR-' . $this->faker->unique()->numberBetween(10000, 99999),
            // 'staff_id'   => User::pluck('id')->random(),
            // 'salary_id'  => Salary::pluck('id')->random(),
            'start_date' => \Carbon\Carbon::now()->startOfMonth(),
            'end_date'   => \Carbon\Carbon::now()->endOfMonth(),
            'status'     => $this->faker->randomElement(['paid', 'unpaid']),
            'comments'   => $this->faker->sentence(6),
            
            // Add the missing leave column here to satisfy the database constraint
            'leave'      => 0, 
        ];
    }
}