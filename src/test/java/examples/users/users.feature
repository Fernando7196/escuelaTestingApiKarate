@regresion
Feature: Automatizar el backend de Pet Store

  Background:
    * url apiPetStore
    * def petCreation = read('classpath:examples/jsonData/crearMascota.json')
    #aca se crea otro para editar la mascota y obtener el json

                        #esto es un tag para poder hacer el TEST-11
  @TEST-1               #@crearMascota
  Scenario: Verificar la creación de una nueva mascota en Pet Store - OK
    Given path 'pet'
    And request petCreation
    When method post
    Then status 200
    And print response


  @TEST-2
  Scenario: Verificar el estado de la mascota que se ha creado anteriormente (available) - OK
    Given path 'pet/findByStatus'
    And param status = 'available'
    When method get
    Then status 200
    And print response

  @TEST-3
  Scenario: Verificar el estado de la mascota que se ha creado anteriormente (pending) - OK
    Given path 'pet/findByStatus'
    And param status = 'pending'
    When method get
    Then status 200
    And print response

  @TEST-4
  Scenario: Verificar el estado de la mascota que se ha creado anteriormente (sold) - OK
    Given path 'pet/findByStatus'
    And param status = 'sold'
    When method get
    Then status 200
    And print response

  @TEST-5
  Scenario Outline: Verificar el estado de la mascota que se ha creado anteriormente (las 3 opciones en una sola) - OK
    Given path 'pet/findByStatus'
    And param status = '<estado>'
    When method get
    Then status 200
    And print response

    Examples:
      |estado|
      |available|
      |pending|
      |sold|


  @TEST-6
  Scenario: Verificar la actualización de una mascota previamente registrada en Pet Store - OK
    * def petEdition =
      """
        {
      "id": 1,
      "category": {
        "id": 0,
        "name": "string"
      },
      "name": "Goku",
      "photoUrls": [
        "string"
      ],
      "tags": [
        {
          "id": 0,
          "name": "string"
        }
      ],
      "status": "sold"
      }
      """

    Given path 'pet'
    And request petEdition
    When method put
    Then status 200
    And print response


  @TEST-7
  Scenario Outline: Buscar una mascota con su ID creada anteriormente en Pet Store - OK
    Given path 'pet/' + '<idPet>'
    When method get
    Then status 200
    And print response

    Examples:
      |idPet|
      |1|
      |2|
      |3|

    #Chekear a fondo si estara bien
  @TEST-8
  Scenario: Buscar una mascota con su ID creada anteriormente en Pet Store - OK
    Given path 'pet/' + '<idPet>'
    When method get
    Then status 200
    And print response


  @TEST-9
  Scenario Outline: Verificar la eliminación de una mascota - OK
    Given path 'pet/' + '<idPet>'
    When method delete
    Then status 200
    And print response

    Examples:
      |idPet|
      |1|
      |2|
      |3|


  @TEST-10
  Scenario: Subir una imagen para una mascota existente - OK
    * def petId = 4

    Given path 'pet', petId, 'uploadImage'
    And multipart file file = { read: 'perrito.jpg', filename: 'perrito.jpg', contentType: 'image/jpeg' }
    And multipart field additionalMetadata = 'Foto de perfil actualizada'
    When method post
    Then status 200



  #Caso de prueba para usarlo despues
  @TEST-11
  Scenario: Buscar una mascota con su ID creada anteriormente en Pet Store - OK
    Given path 'pet/' + '<idPet>'
    When method get
    Then status 200
    And print response




    #mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @TEST-1" -Dkarate.env=cert
    #mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @TEST-1"




  