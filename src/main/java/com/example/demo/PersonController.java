package com.example.demo;

import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/persons")
@CrossOrigin(origins = "*") // dozvoli frontend-u da pristupa
public class PersonController {
    private final PersonRepository repo;

    public PersonController(PersonRepository repo) {
        this.repo = repo;
    }

    @PostMapping
    public Person createPerson(@RequestBody Person person) {
        return repo.save(person);
    }

    @GetMapping
    public List<Person> getAllPersons() {
System.out.println("Ovde sam");    	
        return repo.findAll();
    }
    
    @DeleteMapping("/{id}")
    // ja poceo praviti
    public String deletePerson(@PathVariable Long id) {
    	Optional<Person> optFoundPerson =  repo.findById(id);
    	Person foundPerson = optFoundPerson.get();
System.out.println(foundPerson);    	
    	repo.delete(foundPerson);
    	return "Obrisan user: " + foundPerson.getName();
    }
}
