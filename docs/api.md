# API Documentation

This document provides detailed information about the API endpoints available in the Knowledge Engine framework.

## Table of Contents

- [Introduction](#introduction)
- [Authentication](#authentication)
- [Endpoints](#endpoints)
  - [GET /notes](#get-notes)
  - [POST /notes](#post-notes)
  - [GET /notes/:id](#get-notes-id)
  - [PUT /notes/:id](#put-notes-id)
  - [DELETE /notes/:id](#delete-notes-id)
- [Error Handling](#error-handling)
- [Examples](#examples)

## Introduction

The Knowledge Engine API allows you to interact with the Knowledge Engine framework programmatically. You can create, read, update, and delete notes using the provided endpoints.

## Authentication

All API requests must include an authentication token in the `Authorization` header. The token can be obtained by logging in to the Knowledge Engine.

## Endpoints

### GET /notes

Retrieve a list of all notes.

#### Request

```http
GET /notes HTTP/1.1
Host: api.knowledge-engine.com
Authorization: Bearer <token>
```

#### Response

```json
[
  {
    "id": "1",
    "title": "Note 1",
    "content": "This is the content of note 1."
  },
  {
    "id": "2",
    "title": "Note 2",
    "content": "This is the content of note 2."
  }
]
```

### POST /notes

Create a new note.

#### Request

```http
POST /notes HTTP/1.1
Host: api.knowledge-engine.com
Authorization: Bearer <token>
Content-Type: application/json

{
  "title": "New Note",
  "content": "This is the content of the new note."
}
```

#### Response

```json
{
  "id": "3",
  "title": "New Note",
  "content": "This is the content of the new note."
}
```

### GET /notes/:id

Retrieve a specific note by its ID.

#### Request

```http
GET /notes/1 HTTP/1.1
Host: api.knowledge-engine.com
Authorization: Bearer <token>
```

#### Response

```json
{
  "id": "1",
  "title": "Note 1",
  "content": "This is the content of note 1."
}
```

### PUT /notes/:id

Update a specific note by its ID.

#### Request

```http
PUT /notes/1 HTTP/1.1
Host: api.knowledge-engine.com
Authorization: Bearer <token>
Content-Type: application/json

{
  "title": "Updated Note 1",
  "content": "This is the updated content of note 1."
}
```

#### Response

```json
{
  "id": "1",
  "title": "Updated Note 1",
  "content": "This is the updated content of note 1."
}
```

### DELETE /notes/:id

Delete a specific note by its ID.

#### Request

```http
DELETE /notes/1 HTTP/1.1
Host: api.knowledge-engine.com
Authorization: Bearer <token>
```

#### Response

```json
{
  "message": "Note deleted successfully."
}
```

## Error Handling

The API uses standard HTTP status codes to indicate the success or failure of a request. In case of an error, the response will include a JSON object with an `error` field containing a description of the error.

#### Example Error Response

```json
{
  "error": "Invalid authentication token."
}
```

## Examples

### Example 1: Retrieve All Notes

```http
GET /notes HTTP/1.1
Host: api.knowledge-engine.com
Authorization: Bearer <token>
```

#### Response

```json
[
  {
    "id": "1",
    "title": "Note 1",
    "content": "This is the content of note 1."
  },
  {
    "id": "2",
    "title": "Note 2",
    "content": "This is the content of note 2."
  }
]
```

### Example 2: Create a New Note

```http
POST /notes HTTP/1.1
Host: api.knowledge-engine.com
Authorization: Bearer <token>
Content-Type: application/json

{
  "title": "New Note",
  "content": "This is the content of the new note."
}
```

#### Response

```json
{
  "id": "3",
  "title": "New Note",
  "content": "This is the content of the new note."
}
```

### Example 3: Retrieve a Specific Note

```http
GET /notes/1 HTTP/1.1
Host: api.knowledge-engine.com
Authorization: Bearer <token>
```

#### Response

```json
{
  "id": "1",
  "title": "Note 1",
  "content": "This is the content of note 1."
}
```

### Example 4: Update a Specific Note

```http
PUT /notes/1 HTTP/1.1
Host: api.knowledge-engine.com
Authorization: Bearer <token>
Content-Type: application/json

{
  "title": "Updated Note 1",
  "content": "This is the updated content of note 1."
}
```

#### Response

```json
{
  "id": "1",
  "title": "Updated Note 1",
  "content": "This is the updated content of note 1."
}
```

### Example 5: Delete a Specific Note

```http
DELETE /notes/1 HTTP/1.1
Host: api.knowledge-engine.com
Authorization: Bearer <token>
```

#### Response

```json
{
  "message": "Note deleted successfully."
}
```
