class AnimalValueError(ValueError):
    pass

def produce_animal_sound(animal_type):
    
    if animal_type not in ['cat', 'dog', 'fish']:
        raise AnimalValueError(f"{animal_type} is not a valid animal type")
    elif animal_type == 'cat':
        print("meow")
    elif animal_type == 'dog':
        print("woof")    


produce_animal_sound('cat')
produce_animal_sound('dog')
produce_animal_sound('fish')
produce_animal_sound('bird')

